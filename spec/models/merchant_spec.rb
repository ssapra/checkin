require 'spec_helper'

describe Merchant do
  describe '#valid' do
    before do
      @merchant = build(:merchant)
    end

    it 'should be valid' do
      expect(@merchant).to be_valid
    end
  end

  describe '#invalid' do
    context 'when the name is empty' do
      before do
        @merchant = build(:merchant, name: '')
      end

      it 'is invalid' do
        expect(@merchant).to_not be_valid
      end
    end

    context 'when the name is not unique' do
      before do
        @merchant = create(:merchant, name: 'Great Clips')
        @merchant2 = build(:merchant, name: 'Great Clips')
      end

      it 'is invalid' do
        expect(@merchant2).to_not be_valid
      end
    end
  end
end
