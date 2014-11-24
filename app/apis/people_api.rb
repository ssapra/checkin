include Napa::SortableApi
class PeopleApi < Grape::API
  desc 'Get a list of people'
  helpers do
    def person
      @person ||= Person.where(id: params[:id])[0]
    end

    def authenticate!
      error!('404 Not Found', 404) unless person
    end
  end

  params do
    optional :ids, type: String, desc: 'comma separated person ids'
  end
  get do
    people = params[:ids] ? Person.where(id: params[:ids].split(',')) : Person.all
    represent people, with: PeopleRepresenter
  end

  params do
    requires :id, type: Integer, desc: 'Find person by id'
  end
  route_param :id do
    desc 'Get a person'
    get do
      authenticate!
      represent person, with: PeopleRepresenter
    end

    resource :merchants do
      desc 'Get a list of merchants for a person checked in sorted by frequency'
      params do
        optional :limit, type: Integer, desc: 'Limit number of merchants returned'
      end
      get do
        authenticate!
        frequencies = Hash.new(0)
        person.merchants.each { |m| frequencies[m.id] += 1 }
        sorted_merchants = frequencies.sort { |a, b| b[1] <=> a[1] }
        sorted_merchants = sorted_merchants.take(params[:limit]) if params[:limit] && params[:limit] > 0
        { data: sorted_merchants.map { |m| { num_of_checkins: m[1], merchant_id: m[0] } } }
      end
    end
  end
end
