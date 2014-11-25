require 'spec_helper'

def app
  ApplicationApi
end

describe MerchantsApi do
  include Rack::Test::Methods

  describe 'GET /merchants' do
    context 'when there is one merchant' do
      before do
        @merchant = create(:merchant)
      end

      it 'returns a list of merchant ids and names' do
        get '/merchants'
        json = JSON.parse(last_response.body)
        expect(json['data'][0]['id']).to eq @merchant.id.to_s
      end
    end

    context 'when there are many merchants' do
      before do
        3.times { create(:merchant) }
        get '/merchants'
        @json = JSON.parse(last_response.body)
      end

      it 'returns all the merchants' do
        expect(@json['data'].length).to eq 3
      end
    end

    context 'when the ids parameter is present' do
      before do
        @merchant = create(:merchant, name: 'ABC')
        @merchant2 = create(:merchant, name: 'Bob\'\s Pizza')
        @merchant3 = create(:merchant, name: 'Cuper Cuts')
        get '/merchants', ids: "#{@merchant.id},#{@merchant2.id}"
        @json = JSON.parse(last_response.body)
      end

      it 'returns only the first two merchants' do
        expect(@json['data'].length).to eq 2
        expect(@json['data'][0]['id']).to eq @merchant.id.to_s
        expect(@json['data'][1]['id']).to eq @merchant2.id.to_s
      end
    end

    context 'when the sort parameter is present' do
      before do
        @merchant = create(:merchant, name: 'ABC')
        @merchant2 = create(:merchant, name: 'Bob\'\s Pizza')
      end

      context 'when the parameter is name' do
        before do
          get '/merchants', sort: 'name'
        end

        it 'orders them in ascending order' do
          json = JSON.parse(last_response.body)
          expect(json['data'][0]['id']).to eq @merchant.id.to_s
          expect(json['data'][1]['id']).to eq @merchant2.id.to_s
        end
      end

      context 'when the parameter is -name' do
        before do
          get '/merchants', sort: '-name'
        end

        it 'orders them in descending order' do
          json = JSON.parse(last_response.body)
          expect(json['data'][0]['id']).to eq @merchant2.id.to_s
          expect(json['data'][1]['id']).to eq @merchant.id.to_s
        end
      end
    end
  end

  describe 'GET /merchants/:id' do
    context 'when the merchant cannot be found' do
      before do
        get '/merchant/100'
      end

      it 'should return a 404 status code' do
        expect(last_response.status).to eq 404
      end
    end

    context 'when the merchant is found' do
      before do
        @merchant = create(:merchant)
        get "/merchants/#{@merchant.id}"
        @json = JSON.parse(last_response.body)
      end

      it 'should return the merchant' do
        expect(@json['data']['id']).to eq @merchant.id.to_s
      end
    end
  end

  describe 'GET /people/:id/merchants' do
    context 'when the merchant cannot be found' do
      before do
        get '/merchant/100'
      end

      it 'should return a 404 status code' do
        expect(last_response.status).to eq 404
      end
    end

    context 'when a merchant has one checkin' do
      before do
        @person = create(:person)
        merchant = create(:merchant)
        create(:checkin, merchant_id: merchant.id, person_id: @person.id)
        get "/merchants/#{merchant.id}/people"
        @json = JSON.parse(last_response.body)
      end

      it 'returns only the merchant and a person with 1 checkin' do
        expect(@json['data'][0]['num_of_checkins']).to eq 1
        expect(@json['data'][0]['person_id']).to eq @person.id
      end
    end

    context 'when a merchant has checkins from several people' do
      before do
        person = create(:person)
        @merchant = create(:merchant)
        5.times { create(:checkin, merchant_id: @merchant.id, person_id: person.id) }

        person2 = create(:person)
        3.times { create(:checkin, merchant_id: @merchant.id, person_id: person2.id) }
      end

      context 'and the limit parameter is not present' do
        before do
          get "/merchants/#{@merchant.id}/people"
          @json = JSON.parse(last_response.body)
        end

        it 'returns only two people with their frequencies ' do
          expect(@json['data'].length).to eq 2
          expect(@json['data'][0]['num_of_checkins']).to eq 5
          expect(@json['data'][1]['num_of_checkins']).to eq 3
        end
      end

      context 'and the limit parameter is present' do
        before do
          get "/merchants/#{@merchant.id}/people", limit: 1
          @json = JSON.parse(last_response.body)
        end

        it 'returns only one person with the frequency ' do
          expect(@json['data'].length).to eq 1
          expect(@json['data'][0]['num_of_checkins']).to eq 5
        end
      end
    end
  end

end
