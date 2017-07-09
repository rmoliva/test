# encoding: utf-8
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Products::Show, type: :model do
  let(:user_session) { create_user_session }
  let(:user) { user_session.user }
  let(:product) { Product.make! }
  let(:power) { Powers::Network.new(user_session) }
  let(:service) do
    Services::Products::Show.new(
      power,
      id: product.id
    )
  end

  before(:each) do
    # Asignar el rol de network_products al usuario para que pueda acceder
    # a las cuentas
    Role.make!(
      user: user,
      role: 'network_products'
    )
  end

  subject { service.execute! }

  it 'returns a successful product information' do
    expect(subject).to eql(product.as_api_response(:base))
  end
end
