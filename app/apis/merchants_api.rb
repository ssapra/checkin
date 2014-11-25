include Napa::SortableApi
class MerchantsApi < Grape::API
  helpers do
    def merchant
      @merchant ||= Merchant.where(id: params[:id])[0]
    end

    def authenticate!
      error!('404 Not Found', 404) unless merchant
    end
  end

  desc 'Get a list of merchants'
  params do
    optional :ids, type: String, desc: 'comma separated merchant ids'
    optional :sort, type: String, desc: 'Sort merchants by parameter'
  end
  get do
    merchants = params[:ids] ? Merchant.where(id: params[:ids].split(',')) : Merchant.all
    merchants = sort_from_params(merchants, params[:sort])
    represent merchants, with: MerchantRepresenter
  end

  params do
    requires :id, type: String, desc: 'Merchant id'
  end
  route_param :id do
    desc 'Get a single merchant'
    get do
      authenticate!
      represent merchant, with: MerchantRepresenter
    end

    resource :people do
      desc 'Get a list of people sorted by frequency of checkins'
      params do
        optional :limit, type: Integer, desc: 'Limit number of people returned'
      end
      get do
        authenticate!
        frequencies = Hash.new(0)
        merchant.people.each { |p| frequencies[p.id] += 1 }
        sorted_people = frequencies.sort { |a, b| b[1] <=> a[1] }
        sorted_people = sorted_people.take(params[:limit]) if params[:limit] && params[:limit] > 0
        { data: sorted_people.map { |p| { num_of_checkins: p[1], person_id: p[0] } } }
      end
    end
  end
end
