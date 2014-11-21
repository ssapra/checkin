require 'json'
require 'open-uri'

Merchant.destroy_all
json = JSON.parse(open('merchants.json').read)

json['data'].each do |merchant_data|
  Merchant.create(name: merchant_data[0].downcase.camelize)
end
