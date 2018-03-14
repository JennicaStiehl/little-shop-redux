require 'csv'
require './app/models/merchant'

CSV.foreach('./data/merchants.csv',
            headers: true,
            header_converters: :symbol) do |data|
  hash = data.to_h
  hash[:id] = hash[:id].to_i
  Merchant.create(hash)
end
