namespace :dev do
  task :rebuild => ["db:drop","db:setup",:fake]
  # db:drop db:create db:schema:load db:seed :fake

  task :fake => :environment do
    User.delete_all
    Event.delete_all
    Attendee.delete_all

    puts "Creating fake data"
    user = User.create!(:email=> "mxy@gmail.com", :password=>'123456')

    50.times do |i|
      e = Event.create!(:name=>Faker::App.name)
      10.times do |j|
        e.attendees.create(:name=>Faker::Name.name) 
      end
    end
  end
end


