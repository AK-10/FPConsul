require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    context 'name' do
      it { should validate_presence_of(:name) }
      it { should validate_length_of(:name).is_at_most(50) }
    end
    
    context 'email' do
      it { should validate_presence_of(:email) }
      it { should validate_length_of(:email).is_at_most(100) }
      it { should validate_uniqueness_of(:email) }
      
      it { should allow_value('test@test.com').for(:email) }
      it { should_not allow_value('abcdefg').for(:email) }
    end
    
    context 'password' do
      it { should have_secure_password }
    end
  end
end
