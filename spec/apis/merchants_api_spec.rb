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
        @merchant = create(:merchant)
        @merchant2 = create(:merchant)
        @merchant3 = create(:merchant)
        get '/merchants'
        @json = JSON.parse(last_response.body)
      end

      it 'returns all the merchants' do
        expect(@json['data'].length).to eq 3
      end
    end

    context 'when the sort parameter is present' do
      before do
        @merchant = create(:merchant, name: 'ABC')
        @merchant2 = create(:merchant, name: 'Bob\'\s Pizza')
      end

      context 'when the parameter is name' do
        before do
          get '/merchants', {sort: 'name'}
        end

        it 'orders them in ascending order' do
          json = JSON.parse(last_response.body)
          expect(json['data'][0]['id']).to eq @merchant.id.to_s
          expect(json['data'][1]['id']).to eq @merchant2.id.to_s
        end
      end

      context 'when the parameter is -name' do
        before do
          get '/merchants', {sort: '-name'}
        end

        it 'orders them in descending order' do
          json = JSON.parse(last_response.body)
          expect(json['data'][0]['id']).to eq @merchant2.id.to_s
          expect(json['data'][1]['id']).to eq @merchant.id.to_s
        end
      end
    end
  end
end
