class CheckinsApi < Grape::API
  desc 'Create a checkin'
  params do
    requires :merchant_id, type: Integer, desc: 'Merchant id'
    requires :email, type: String, desc: 'The email of the person'
  end
  post do
    merchant = Merchant.where(id: params[:merchant_id])[0]
    person = Person.find_or_create_by(email: params[:email])
    if merchant.nil?
      present_error(404, "Could not find merchant with id #{params[:merchant_id]}")
    elsif !person.valid?
      present_error(422, "Invalid email #{params[:email]}")
    else
      Checkin.create(merchant_id: merchant.id, person_id: person.id)
    end
  end
end
