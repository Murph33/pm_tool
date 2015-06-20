# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do
  name = Faker::Commerce.product_name
  description = Faker::Lorem.sentence(3)
  time = (rand(10+1)).days.from_now
  Project.create title: name, description: description, due_date: time
end



# ["Research & Development", "Human Resources", "Marketing", "Sales",
#   "Information Technologies", "Management"].each {|el| Tag.create name:el}
