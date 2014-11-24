require 'spec_helper'

def app
  ApplicationApi
end

describe CheckinsApi do
  include Rack::Test::Methods

  describe 'POST /checkins' do
    context 'when the merhant is not found' do
      before do
        @merchant_id = 10
        post '/checkins', merchant_id: @merchant_id, email: 'ssapra@uchicago.edu'
        @json = JSON.parse(last_response.body)
      end

      it 'should return a 404 status code' do
        expect(last_response.status).to eq 404
      end

      it 'should return an error message' do
        expect(@json['error']['message']).to eq "Could not find merchant with id #{@merchant_id}"
      end
    end

    context 'when the email is invalid' do
      before do
        merchant = create(:merchant)
        @email = 'ssapra'
        post '/checkins', merchant_id: merchant.id, email: @email
        @json = JSON.parse(last_response.body)
      end

      it 'should return a 422 status code' do
        expect(last_response.status).to eq 422
      end

      it 'should return an error message' do
        expect(@json['error']['message']).to eq "Invalid email #{@email}"
      end
    end

    context 'when the merchant id and email are valid' do
      before do
        @person = create(:person)
        @merchant = create(:merchant)
        @checkins_count = Checkin.count
        post '/checkins', merchant_id: @merchant.id, email: @person.email
      end

      it 'creates a new checkin' do
        expect(Checkin.count).to eq @checkins_count + 1
      end
    end
  end
end
