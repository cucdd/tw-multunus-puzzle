class TwitterWorker
  include Sidekiq::Worker

  # Don't retry on error as it would be enqueued back again
  sidekiq_options retry: false

  def perform(user)
    info = Hash.new
    client =  Rails.configuration.tw_client

    begin

      # Get latest 10 tweets excluding replies but including retweets
      client.user_timeline(user, trim_user: true, exclude_replies: true,
                           include_rts: true).take(10).each do |tweet|

        # Get list of users who retweeted this tweet
        retweeter_ids  = client.retweeters_of(tweet.id, ids_only: true)

        # only if the tweet was retweeted
        unless retweeter_ids.empty?

          # Get details of user who retweeted
          users = client.users(retweeter_ids, method: :get, include_entities: false)

          # Store user image and follower count inside a hash
          users.each do |user|
            # If a single user retweeted multiple tweets
            # add his follower count to his existing entry 
            if info.has_key?( user.profile_image_url('original') )
              new_count = info[user.profile_image_url('original')] + user.followers_count
              info.store(user.profile_image_url('original'), new_count)
            else
              info.store(user.profile_image_url('original'), user.followers_count)
            end
          end
        end

      end

    rescue Twitter::Error::TooManyRequests => error
      TwitterWorker.perform_in(error.rate_limit.reset_in, user)
    rescue Twitter::Error => error
      puts error.message
    end

    # sort by follower count and extract top 10 users
    info = info.sort_by &:last
    info = info.reverse!.shift(10)

    # convert to hash again
    info = Hash[*info.flatten]

    # store in memory, will be overwritten on next update
    $redis.set("#{user}:score", info.to_json)
  end
end
