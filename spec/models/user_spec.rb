require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it 'is valid with name, email' do
    user = User.new(
      name: '金山　太郎',
      email: 'aaaa@mfw.com',
      password: 'password',
      password_confirmation: 'password',
    )
    expect(user).to be_valid
  end

  it 'is not valid with blank name, blank email' do
    user = User.new(
      name: '',
      email: '',
      password: 'password',
      password_confirmation: 'password', 
    )

    expect(user).to be_invalid
  end
end
