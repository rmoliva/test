# encoding: utf-8
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Products::Update, type: :model do
  let(:user_session) { create_user_session }
  let(:user) { user_session.user }
  let(:product) { Product.make! }
  let(:new_name) { Faker::Name.name }
  let(:power) { Powers::Network.new(user_session) }

  before(:each) do
    # Asignar el rol de network_products al usuario para que pueda acceder
    # a las cuentas
    Role.make!(
      user: user,
      role: 'network_products'
    )
  end

  context 'with valid attributes' do
    let(:service) do
      Services::Products::Update.new(
        power,
        id: product.id,
        product: {
          name: new_name
        }
      )
    end

    subject { service.execute! }

    it 'should not add or delete a record' do
      product # Ensure record is created
      expect { subject }.to change(Product, :count).by(0)
    end

    it 'should attributes have changed' do
      subject
      product.reload
      expect(product.name).to eql(new_name)
    end

    it 'returns a successful record information' do
      expect(subject).to eql(product.reload.as_api_response(:base))
    end
  end # with valid attributes

  context 'with invalid attributes' do
    let(:service) do
      Services::Products::Update.new(
        power,
        id: product.id,
        product: {
          name: nil
        }
      )
    end

    subject { service.execute! }

    it 'should raise an error' do
      expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end # with invalid attributes
end
