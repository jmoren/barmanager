# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin = User.create({
  username: "admin",
  email: "admin@email.com",
  password: "admin123",
  password_confirmation: "admin123",
  admin: true
})

45.times do |i|
  Table.create( number: i + 1, status: 'closed')
end

Category.create([
  {name: "Wiskys"}, {name: "Licores Cusenier"}, {name: "Cafeteria"},
  {name: "Sandwichs"}, {name: "Cervezas"}, {name: "Pizzas"}, {name: "Postres"},
  {name: "Gaseosas"}, {name: "Vinos"}, {name: "Minutas"}, {name: "Picadas"},
  {name: "Aperitivos"}])


5.times do |i|
  Item.create(description: "Coca#{i}", day_price: 10 * i + 1, night_price: 10 * i + 10, category_id: 1, code: i + 10)
end
