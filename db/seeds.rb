# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Event.destroy_all

Event.create(name:"First", description:"Best ever", address:"Invalidenstr. 86 Berlin", user: User.last)

Event.create(name:"Second", description:"Second best ever", address:"Schlegelstr. 20 Berlin", user: User.last)

Event.create(name:"Third", description:"Third best ever", address:"Schwedter Str. 75 Berlin", user: User.last)

Event.create(name:"Fourth", description:"Fourth best ever", address:"Oranienstr. 25 Berlin", user: User.last)

Event.create(name:"Fifth", description:"Fifth best ever", address:"Chaussesstr. 125 Berlin", user: User.last)

Event.create(name:"Sixth", description:"Sixth best ever", address:"Friedrichstr. 15 Berlin", user: User.last)

Event.create(name:"Seventh", description:"Seventh best ever", address:"Rudy-Dutschke Str. 25 Berlin", user: User.last)
