# encoding: utf-8
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Products::Destroy, type: :model do
  let(:user_session) { create_user_session }
  let(:user) { user_session.user }
  let(:product) { Product.make! }
  let(:power) { Powers::Network.new(user_session) }
  let(:service) do
    Services::Products::Destroy.new(
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

  describe 'with existing record' do
    before(:each) do
      # Ensure the product is created before running tests
      product
    end
    subject { service.execute! }

    it 'should destroy the record' do
      expect { subject }.to change(Product, :count).by(-1)
    end

    it 'returns the record information' do
      expect(subject).to eql(
        product.as_api_response(:base)
      )
    end
  end # with existing record

  describe 'without existing record' do
    before(:each) do
      product.destroy
    end
    subject { service.execute! }

    it 'should raise an error' do
      expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end # with valid attributes
end
