require 'csv'
require './app/models/item.rb'

CSV.foreach('./data/items.csv', headers: true, header_converters: :symbol) do |row|
  attributes = row.to_h
  attributes[:id] = attributes[:id].to_i
  attributes[:merchant_id] = attributes[:merchant_id].to_i
  attributes[:title] = attributes.delete(:name)
  attributes[:price] = attributes.delete(:unit_price).to_i
  attributes[:image] = 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2b/WelshCorgi.jpeg/220px-WelshCorgi.jpeg'
  Item.create(attributes)
end
