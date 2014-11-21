class ApplicationApi < Grape::API
  format :json
  extend Napa::GrapeExtenders

  mount HelloApi => '/'
  mount MerchantsApi => '/merchants'

  add_swagger_documentation
end
