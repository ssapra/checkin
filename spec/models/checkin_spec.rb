require 'spec_helper'

describe Checkin do
  describe '#valid' do
    context 'when the foreign keys are present' do
      before do
      @checkin = build(:checkin)
      end

      it 'should be valid' do
        expect(@checkin).to be_valid
      end
    end
  end

  describe '#invalid' do
    context 'when the merchant id is missing' do
      before do
        @checkin = build(:checkin, merchant_id: nil)
        @checkin.save
      end

      it 'should not be valid' do
        expect(@checkin).to_not be_valid
      end
    end

    context 'when the person id is missing' do
      before do
        @checkin = build(:checkin, person_id: nil)
        @checkin.save
      end

      it 'should not be valid' do
        expect(@checkin).to_not be_valid
      end
    end
  end
end
