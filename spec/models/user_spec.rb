require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it 'is valid with name, email' do
    user = build(:user)
    
    expect(user).to be_valid
  end

  it 'is invalid with blank name, blank email' do
    user = build(:user)
    user.name = ''
    user.email = ''

    expect(user).to be_invalid
  end

  it 'is invalid with blank name' do
    user = build(:user)
    user.name = ''

    expect(user).to be_invalid
  end

  it 'is invalid with blank email' do
    user = build(:user)
    user.email = ''

    expect(user).to be_invalid
  end

  it 'is invalid with unnormalized email' do
    user = build(:user)
    user.email = 'aaaaaaaaaaaa'

    expect(user).to be_invalid
  end
end
