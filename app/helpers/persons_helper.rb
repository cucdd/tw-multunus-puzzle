module PersonsHelper
  def fetch_twitter_score
    score = $redis.get("#{@person.name}:score")
    score ? JSON.parse(score) : []
  end
end
