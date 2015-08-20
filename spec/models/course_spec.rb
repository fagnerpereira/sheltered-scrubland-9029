require 'rails_helper'

describe Course do

  describe 'validators' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }    
  end

  describe 'associations' do
    it { should have_many :classrooms }
    it { should have_many :students }
  end

  describe '#valid?' do
    subject(:course) { build(:course, attributtes) }

    context 'when it is success' do
      let(:attributtes) { { name: 'systems analyst', description: 'systems analyst' } }

      it { expect(course).to be_valid }
    end

    context 'when something is wrong' do 
      context 'when there is no name' do
        let(:attributtes) { { description: 'systems analyst' } }

        it { expect(course).to_not be_valid }
      end

      context 'when there is no description' do
        let(:attributtes) { { name: 'systems analyst' } }

        it { expect(course).to_not be_valid }
      end
    end
  end
end