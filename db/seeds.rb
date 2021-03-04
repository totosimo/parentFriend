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
