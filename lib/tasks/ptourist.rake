namespace :ptourist do
  MEMBERS=["mike","carol","alice","greg","marsha","peter","jan","bobby","cindy"]
  
  desc "reset all data"
  task reset_all: [:users,:subjects] do
  end

  desc "deletes things, images, and links"
  task delete_subjects: :environment do
    puts "removing #{Thing.count} things and #{ThingImage.count} thing_images"
    puts "removing #{Image.count} images"
  end

  desc "delete all data"
  task delete_all: [:delete_subjects] do
    puts "removing #{User.count} users"
  end

  desc "reset users"
  task users: [:delete_all] do
    puts "creating users: #{MEMBERS}"
  end

  desc "reset things, images, and links"
  task subjects: [:users] do
    puts "creating things, images, and links"
  end

end
