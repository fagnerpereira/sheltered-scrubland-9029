require 'rails_helper'

RSpec.describe Classroom, type: :model do
  describe 'associations' do
    it { should belong_to :student }
    it { should belong_to :course }
  end
end
