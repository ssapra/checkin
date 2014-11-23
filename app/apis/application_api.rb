class ApplicationApi < Grape::API
  format :json
  extend Napa::GrapeExtenders

  mount MerchantsApi => '/merchants'
  mount CheckinsApi => '/checkins'
  mount PeopleApi => '/people'

  add_swagger_documentation
end
