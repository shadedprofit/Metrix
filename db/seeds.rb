require 'faker'
 
# Create Users
1.times do 
  # Create an admin user
  admin = User.new(
    name:     'Admin User',
    email:    'admin@example.com',
    password: 'helloworld'
  )
  admin.skip_confirmation!
  admin.save!
 
  # Create a member
  member = User.new(
    name:     'Member User',
    email:    'member@example.com',
    password: 'helloworld'
  )
  member.skip_confirmation!
  member.save!
end

5.times do
  user = User.new(
    name:     Faker::Internet.user_name,
    email:    Faker::Internet.email,
    password: Faker::Internet.password(10)
  )
  user.skip_confirmation!
  user.save!
end
users = User.all

# Create Registered Applications
50.times do # Originally 15
  RegisteredApplication.create!(
    user:         users.sample,
    name:         Faker::Internet.domain_word,
    url:          Faker::Internet.url
  )
end
registered_applications = RegisteredApplication.all

 # Create Events
700.times do # Originally 50
  event = Event.create!(
    registered_application: registered_applications.sample,
    name:  Faker::Lorem.word
  )
end
events = Event.all


 
 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{RegisteredApplication.count} registered applications created"
 puts "#{Event.count} events created"

