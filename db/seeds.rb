require 'csv'
require './app/models/item.rb'
require './app/models/merchant'

options = { headers: true, header_converters: :symbol }
CSV.foreach('./data/items.csv', options) do |row|
  attributes = row.to_h
  attributes[:title] = attributes.delete(:name)
  attributes[:price] = attributes.delete(:unit_price)
  attributes[:image] = 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2b/WelshCorgi.jpeg/220px-WelshCorgi.jpeg'
  Item.create(attributes)
end

CSV.foreach('./data/merchants.csv', options) do |data|
  hash = data.to_h
  hash[:id] = hash[:id]
  Merchant.create(hash)
end
