include Napa::SortableApi
class MerchantsApi < Grape::API
  desc 'Get a list of merchants'
  params do
    optional :sort, type: String, desc: 'Sort merchants by parameter'
  end
  get do
    merchants = Merchant.all
    merchants = sort_from_params(merchants, params[:sort])
    represent merchants, with: MerchantRepresenter
  end
end
