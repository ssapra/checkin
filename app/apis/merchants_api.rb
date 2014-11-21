class MerchantsApi < Grape::API
  desc 'Get a list of merchants'
  params do
    optional :ids, type: Array, desc: 'Array of merchant ids'
  end
  get do
    merchants = params[:ids] ? Merchant.where(id: params[:ids]) : Merchant.all
    represent merchants, with: MerchantRepresenter
  end
end
