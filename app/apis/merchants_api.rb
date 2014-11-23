class MerchantsApi < Grape::API
  desc 'Get a list of merchants'
  get do
    merchants = Merchant.all
    represent merchants, with: MerchantRepresenter
  end
end
