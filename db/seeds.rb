require 'open-uri'
require 'faker'
require 'json'

starttime = Time.now

puts "Deleting all database entries..."

Message.delete_all
Event.delete_all
Chatroom.delete_all
User.delete_all

puts "Done deleting. Starting seeding now."
puts

# Users #######################################

if Rails.env.production?
  puts "Detected production environment."
  usercount = 100
else
  puts "Did not detect production environment."
  usercount = 20
end

# Calls random user profile picture API and parses json response into
# an array of picture URLs
image_api_url = "https://randomuser.me/api/?results=#{usercount}&nat=de&inc=picture,name&noinfo"
api_response_json = open(image_api_url).read
api_response_parsed = JSON.parse(api_response_json)
image_url_array = []
# api_response_parsed["results"].each do | child |
#   image_url_array << child["picture"]["large"]
# end

def create_bios
  bios = [
    "Hi I am a happy #{["father", "mother"].sample} of #{rand(1..6)}!",
    "We love Berlin and the many #{["playgrounds", "skate parks", "outdoor activities"].sample} it offers, and we are looking forward to meeting #{["happy", "international", "easy going"].sample} people.",
    "We are young parents in #{["Moabit", "Mitte", "Steglitz"].sample} and love #{["outdoor activities", "inline skates", "dancing"].sample}.",
    "We are parents of #{rand(1..6)} and we love everything that has #{["skates", "wheels", "wings"].sample}.",
    "I am a single #{["mother", "father"].sample} new to #{["Pankow", "Schöneberg", "Kreuzberg"].sample} and would love to find some parent friends for our kids to play together and also have some #{["interesting conversations", "nice picnic", "fun at Berlin's public swimming pools"].sample} with other parents.",
    "Our #{["twins", "triplets", "quadruplets"].sample} keep us busy exploring Berlin each day with them and we would love to meet other expat parents to go #{["on those adventures", "to the cinema", "for hiking"].sample} together.",
    "Me and my wife are both Le Wagon #{["fullstack developer", "data science", "mobile developer"].sample} alumni and we are seeking other devs to hang out and tech talk while our #{rand(1..6)} kids play in the playground."
  ]
  return bios
end

email_suffix = 1
puts "Creating #{usercount} users..."
image_url_array.each do | imageurl |
  bios_list = create_bios
  user = User.new(
    email: "test#{email_suffix}@test.com",
    password: "secure",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    bio: bios_list.sample,
    date_of_birth: "#{rand(1966..1996)}-#{rand(1..12)}-#{rand(1..28)}",
    latitude: "#{rand(52.434620..52.562476).round(6)}",
    longitude: "#{rand(13.280831..13.572970).round(6)}"
  )
  # Save photos with Active Record to Cloudinary:
  photo = URI.open(imageurl)
  user.photo.attach(io: photo, filename: 'name.jpg', content_type: 'image/jpg')
  user.save
  User.last == "" ? (puts "Error!") : (puts "Added #{User.last.first_name} #{User.last.last_name}")
  email_suffix += 1
end
puts "Finished creating users!"
puts

# Chatrooms  #######################################
# puts "Creating chatrooms..."
# Chatroom.create(name: 'Tom')
# Chatroom.create(name: 'Silvia')
# Chatroom.create(name: 'Sergey')
# Chatroom.create(name: 'Moabit is beste!')
# Chatroom.create(name: 'Picknick in Treptow')
# puts "Finished!"

# Events #######################################

event_list = [
  [ "Birthday Party on Skates", "We will celebrate the 4th birthday of our son Oscar at the Gleisdreieck Skatepark. Bring your skates and come join us!", "Sports","2021-03-15 16:00:00", "2021-03-15 18:00:00", "Möckernstraße 26, 10963 Berlin", "https://images.unsplash.com/photo-1553803867-48ac36024cba?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1350&q=80" ],

  [ "Playdate at Victoriapark", "We will gather and play in the sand to build some nice castles together", "Playground", "2021-03-23 12:00:00", "2021-03-23 17:00:00", "Viktoriapark, 10965 Berlin", "https://images.unsplash.com/photo-1542868796-20f2ddc9d41f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" ],

  [ "Pancake party at Kindercafe", "We are organizing a pancake party at Kindercafe 'Biene Maja'. We will bring all ingredients and the kids will make the pancakes with us!", "Eating", "2021-03-24 10:00:00", "2021-03-24 16:00:00", "Wilhelmstraße 1-6, 10961 Berlin", "https://images.unsplash.com/photo-1605959255155-832d05b77e6d?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" ],

  [ "A day in the Zoo", "We are 4 families with 7 kids and will go to the zoo together, everyone is welcome to join us!", "Stroll", "2021-03-26 10:00:00", "2021-03-26 17:30:00", "Hardenbergplatz 8, 10787 Berlin", "https://images.unsplash.com/photo-1562805508-5b92dc24212d?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" ],

  [ "Sightseeing Brandenburg Gate", "We organize a sight seeing tour for our 10 year old and will hire a city guide to explain us everything. Come and join and we do the tour together and go for icecreams afterwards!", "Stroll","2021-03-28 11:30:00", "2021-03-28 15:30:00", "Brandenburger Tor, 10117 Berlin", "https://images.unsplash.com/photo-1582738719480-9c959daf59b8?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=663&q=80" ]
]

user_id = 1
puts "Creating #{event_list.length} events..."
event_list.each do | name, description, event_type, date_time_start, date_time_end, address, event_image |
  event = Event.create!(
    name: name,
    description: description,
    event_type: event_type,
    date_time_start: date_time_start,
    date_time_end: date_time_end,
    user: User.all.sample,
    address: address
  )
  # Save photos with Active Record to Cloudinary:
  photo = URI.open(event_image)
  event.photo.attach(io: photo, filename: 'name.webp', content_type: 'image/webp')
  event.save
  Event.last == "" ? (puts "Error!") : (puts "Added #{Event.last.name}")
  user_id += 1
end
puts "Finished creating events!"
puts
puts "Seed procedure completed in #{(Time.now - starttime).round(0)} seconds."
