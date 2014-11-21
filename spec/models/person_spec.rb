require 'spec_helper'

describe Person do

  describe '#valid' do
    context 'when email is valid' do
      before do
        @person = build(:person)
      end

      it 'is valid' do
        expect(@person).to be_valid
      end
    end
  end

  describe '#invalid' do
    context 'when email is empty' do
      before do
        @person = build(:person, email: '')
        @person.save
      end

      it 'is invalid' do
        expect(@person).to_not be_valid
      end

      it 'should have an error on the email attribute' do
        expect(@person.errors[:email].size).to eq 1
      end
    end

    context 'when the email is not formatted correctly' do
      before do
        @person = build(:person, email: 'nonsense@google')
        @person.save
      end

      it 'is invalid' do
        expect(@person).to_not be_valid
      end

      it 'should have an error on the email attribute' do
        expect(@person.errors[:email].size).to eq 1
      end
    end
  end

end
