# encoding: utf-8
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Products::Index, type: :model do
  let(:user_session) { create_user_session }
  let(:user) { user_session.user }
  let(:power) { Powers::Network.new(user_session) }

  before(:each) do
    # Asignar el rol de network_products al usuario para que pueda acceder
    # a las cuentas
    Role.make!(
      user: user,
      role: 'network_products'
    )

    # Crear 30 cuentas
    @products = (0..45).map { Product.make! }
  end

  context 'get all networks' do
    let(:service) { Services::Products::Index.new(power, all: '1') }
    subject { service.execute! }

    it 'should return total count of records' do
      expect(subject[:total_count]).to eql(@products.size)
    end

    it 'should return all the networks' do
      expect(subject[:records]).to eql(@products.as_api_response(:base))
    end
  end

  context 'get paginated networks' do
    context 'get first page' do
      let(:service) { Services::Products::Index.new(power, page: '1') }
      subject { service.execute! }

      it 'should return total count of records' do
        expect(subject[:total_count]).to eql(@products.size)
      end

      it 'should return the first 30 networks' do
        expect(
          subject[:records]
        ).to eql(
          Product.page(1).per(30).as_api_response(:base)
        )
      end
    end

    context 'get second page' do
      let(:service) { Services::Products::Index.new(power, page: '2') }
      subject { service.execute! }

      it 'should return total count of records' do
        expect(subject[:total_count]).to eql(@products.size)
      end

      it 'should return the second 30 networks' do
        expect(
          subject[:records]
        ).to eql(
          Product.page(2).per(30).as_api_response(:base)
        )
      end
    end
  end
end
