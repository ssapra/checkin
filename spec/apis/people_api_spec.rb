require 'spec_helper'

def app
  ApplicationApi
end

describe MerchantsApi do
  include Rack::Test::Methods

  describe 'GET /people' do
    context 'when there is one person' do
      before do
        @person = create(:person)
      end

      it 'returns a list of person ids' do
        get '/people'
        json = JSON.parse(last_response.body)
        expect(json['data'][0]['id']).to eq @person.id.to_s
      end
    end

    context 'when there are many people' do
      before do
        person = create(:person)
        person2 = create(:person)
        person3 = create(:person)
        get '/people'
        @json = JSON.parse(last_response.body)
      end

      it 'returns all the people' do
        expect(@json['data'].length).to eq 3
      end
    end

    context 'when the ids parameter is present' do
      before do
        @person = create(:person)
        @person2 = create(:person)
        person3 = create(:person)
        get '/people', {ids: "#{@person.id},#{@person2.id}"}
        @json = JSON.parse(last_response.body)
      end

      it 'returns only the first two people' do
        expect(@json['data'].length).to eq 2
        expect(@json['data'][0]['id']).to eq @person.id.to_s
        expect(@json['data'][1]['id']).to eq @person2.id.to_s
      end
    end
  end

  describe 'GET /people/:id' do
    context 'when the person cannot be found' do
      before do
        get "/people/100"
        @json = JSON.parse(last_response.body)
      end

      it 'should return a 404 status code' do
        expect(@json['error']['code']).to eq 404
      end
    end

    context 'when a person checks in with one merchant' do
      before do
        person = create(:person)
        @merchant = create(:merchant)
        checkin = create(:checkin, merchant_id: @merchant.id, person_id: person.id)
        get "/people/#{person.id}"
        @json = JSON.parse(last_response.body)
      end

      it 'returns only a single merchant with a frequency of 1' do
        expect(@json['data'][0]['num_of_checkins']).to eq 1
        expect(@json['data'][0]['merchant_id']).to eq @merchant.id
      end
    end

    context 'when a person checks in with several merchants' do
      before do
        @person = create(:person)
        merchant = create(:merchant)
        5.times { create(:checkin, merchant_id: merchant.id, person_id: @person.id) }

        merchant2 = create(:merchant)
        3.times { create(:checkin, merchant_id: merchant2.id, person_id: @person.id) }
      end

      context 'and the limit parameter is not present' do
        before do
          get "/people/#{@person.id}"
          @json = JSON.parse(last_response.body)
        end

        it 'returns only two merchants with their frequencies ' do
          expect(@json['data'].length).to eq 2
          expect(@json['data'][0]['num_of_checkins']).to eq 5
          expect(@json['data'][1]['num_of_checkins']).to eq 3
        end
      end

      context 'and the limit parameter is present' do
        before do
          get "/people/#{@person.id}", { limit: 1 }
          @json = JSON.parse(last_response.body)
        end

        it 'returns only one merchant with its frequency ' do
          expect(@json['data'].length).to eq 1
          expect(@json['data'][0]['num_of_checkins']).to eq 5
        end
      end
    end
  end
end
