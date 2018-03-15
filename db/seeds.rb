require 'csv'
require './app/models/item'
require './app/models/merchant'
require './app/modelraks/invoice'

def parse_csv(filename)
  CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
    yield row.to_h
  end
end

parse_csv('./data/items.csv') do |attributes|
  attributes[:id] = attributes[:id].to_i
  attributes[:merchant_id] = attributes[:merchant_id].to_i
  attributes[:title] = attributes.delete(:name)
  attributes[:price] = attributes.delete(:unit_price).to_i
  attributes[:image] = 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2b/WelshCorgi.jpeg/220px-WelshCorgi.jpeg'
  Item.create(attributes)
end

parse_csv('./data/merchants.csv') do |data|
  Merchant.create(data)
end

parse_csv('./data/invoices.csv') do |data|
  Invoice.create(data)
end
