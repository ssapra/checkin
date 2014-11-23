include Napa::SortableApi
class MerchantsApi < Grape::API
  desc 'Get a list of merchants'
  params do
    optional :ids, type: String, desc: 'comma separated merchant ids'
    optional :sort, type: String, desc: 'Sort merchants by parameter'
  end
  get do
    merchants = params[:ids] ? Merchant.where(id: params[:ids].split(",")) : Merchant.all
    merchants = sort_from_params(merchants, params[:sort])
    represent merchants, with: MerchantRepresenter
  end
end
