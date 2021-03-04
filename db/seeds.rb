require "open-uri"

# Events

Event.destroy_all

    # t.string "name"
    # t.text "description"
    # t.float "latitude"
    # t.float "longitude"
    # t.datetime "date_time_start"
    # t.datetime "date_time_end"
    # t.bigint "user_id", null: false
    # t.string "address"

event_list = [
  [ "Birthday Party on Skates", "We will celebrate the 4th birthday of our son Oscar at the Gleisdreieck Skatepark. Bring your skates and come join us!", 52.493628, 13.375267, "2021-03-15 16:00:00", "2021-03-15 18:00:00", 1, "Möckernstraße 26, 10963 Berlin", "https://images.unsplash.com/photo-1553803867-48ac36024cba?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1350&q=80" ],

  [ "Playdate at Victoriapark", "We will gather and play in the sand to build some nice castles together", 52.487926, 13.381481, "2021-03-23 12:00:00", "2021-03-23 17:00:00", 1, "Viktoriapark, 10965 Berlin", "https://images.unsplash.com/photo-1542868796-20f2ddc9d41f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80" ],

  [ "Sightseeing Brandenburg Gate", "We organize a sight seeing tour for our 10 year old and will hire a city guide to explain us everything. Come and join and we do the tour together and go for icecreams afterwards!", 52.516287, 13.377500, "2021-03-28 11:30:00", "2021-03-28 15:30:00", 1, "Brandenburger Tor, 10117 Berlin", "https://images.unsplash.com/photo-1582738719480-9c959daf59b8?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=663&q=80" ]
]

puts "Creating #{event_list.length} events..."
event_list.each do | name, description, latitude, longitude, date_time_start, date_time_end, user_id, address, event_image |
  event = Event.create(
    name: name,
    description: description,
    latitude: latitude,
    longitude: longitude,
    date_time_start: date_time_start,
    date_time_end: date_time_end,
    user_id: user_id,
    address: address
  )
# After Cloudinary is set up uncomment the following:
  # photo = URI.open(event_image)
  # event.photo.attach(io: photo, filename: 'name.webp', content_type: 'image/webp')
  event.save
  Event.last == "" ? (puts "Error!") : (puts "Added #{Event.name}")
end
puts "Finished!"
