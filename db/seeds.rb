# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do |i|
  Table.create( number: i, status: 'closed')
end

Category.create(name: "Categoria 1")

5.times do |i|
  Item.create(description: "Coca#{i}", price: 10 * i + 1, stock: i + 10, category_id: 1, code: i + 10)
end