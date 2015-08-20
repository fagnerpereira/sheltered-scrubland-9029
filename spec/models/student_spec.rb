require 'rails_helper'

describe Student do

  describe 'validators' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :register_number }
  end

  describe 'associations' do
    it { should have_many :classrooms }
    it { should have_many :courses }
  end

  describe '#valid?' do
    subject(:student) { build(:student, attributtes) }

    context 'when it is success' do
      let(:attributtes) { { name: 'fagner', register_number: '123abc' } }

      it { expect(student).to be_valid }
    end

    context 'when something is wrong' do 
      context 'when there is no name' do
        let(:attributtes) { { register_number: '123abc' } }

        it { expect(student).to_not be_valid }
      end

      context 'when ther is no register_number' do
        let(:attributtes) { { name: 'fagner' } }

        it { expect(student).to_not be_valid }
      end
    end
  end
end