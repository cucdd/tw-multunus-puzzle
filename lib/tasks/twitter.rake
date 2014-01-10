namespace :twitter do
  desc "Load twitter users into redis"
  task :"users:load" => :environment do
    Person.redis='BUG' # bug in redic
    Person.all.each(&:delete)

    persons = {
      github: 'http://pbs.twimg.com/profile_images/651575553/twittergithub2.png',
      timoreilly: 'http://pbs.twimg.com/profile_images/2823681988/f4f6f2bed8ab4d5a48dea4b9ea85d5f1.jpeg',
      twitter: 'http://pbs.twimg.com/profile_images/2284174758/v65oai7fxn47qv9nectx.png',
      martinfowler: 'http://pbs.twimg.com/profile_images/79787739/mf-tg-sq.jpg',
      dhh: 'http://pbs.twimg.com/profile_images/2556368541/alng5gtlmjhrdlr3qxqv.jpeg',
      gvanrossum: 'http://pbs.twimg.com/profile_images/424495004/GuidoAvatar.jpg',
      billgates: 'http://pbs.twimg.com/profile_images/1884069342/BGtwitter.JPG',
      spolsky: 'http://pbs.twimg.com/profile_images/378800000091193257/fcb03c8d0a40048f2537df967239686f.jpeg',
      firefox: 'http:/pbs.twimg.com/profile_images/378800000324784929/1a4ee3fde80808a96ed268a7fb94682d.png'
    }

    persons.each do |name, image|
      Person.create(:name => name, :image => image)
    end

  end
end
