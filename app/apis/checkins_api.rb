class CheckinsApi < Grape::API
  desc 'Create a checkin'
  params do
    requires :merchant_id, type: Integer, desc: 'Find merchant by id'
    requires :email, type: String, desc: 'The email of the person'
  end
  post do
    merchant = Merchant.where(id: params[:merchant_id])[0]
    person = Person.find_or_create_by(email: params[:email])
    if merchant.nil?
      Napa::Logger.logger.debug "Could not find merchant with id #{params[:merchant_id]}"
      error!("Could not find merchant with id #{params[:merchant_id]}", 404)
    end

    unless person.valid?
      Napa::Logger.logger.debug "Invalid email #{params[:email]}"
      error!("Invalid email #{params[:email]}", 422)
    end

    Napa::Logger.logger.debug "Created checkin with person #{person.id} at merchant #{merchant.id}"
    checkin = Checkin.create(merchant_id: merchant.id, person_id: person.id)
    represent checkin, with: CheckinRepresenter
  end
end
