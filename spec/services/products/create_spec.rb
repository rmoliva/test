# encoding: utf-8
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::Products::Create, type: :model do
  let(:user_session) { create_user_session }
  let(:user) { user_session.user }

  describe 'with valid attributes' do
    let(:new_product) { Product.make }
    let(:service) do
      Services::Products::Create.new(
        user_session,
        product: new_product.attributes
      )
    end

    subject { service.execute! }

    it 'should create a new record' do
      expect { subject }.to change(Product, :count).by(1)
    end

    it 'returns a successful record information' do
      expect(subject).to eql(
        Product.last
      )
    end
  end # with valid attributes

  describe 'with invalid attributes' do
    let(:service) do
      Services::Products::Create.new(
        user_session,
        product: {
          name: nil
        }
      )
    end

    subject { service.execute! }

    it 'should raise an error' do
      expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end # with valid attributes
end
