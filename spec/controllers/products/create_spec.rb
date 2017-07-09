# encoding: utf-8
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductsController, 'POST #create', type: :controller do
  let(:new_product) { Product.make }

  context 'without a logged user' do
    before(:each) do
      post(
        :create,
        product: new_product.attributes,
        format: 'json'
      )
    end

    it 'returns 401 status' do
      expect(response.status).to eql(401)
    end

    it 'returns a false JSON' do
      expect(response.body).to be_json_success(false)
    end
  end

  let(:user_session) { create_user_session }
  let(:user) { user_session.user }

  context 'with a logged in user' do
    before(:each) do
      user.reset_persistence_token!
      login(user)
    end

    describe 'with valid attributes' do
      it 'returns a successful record information' do
        post(
          :create,
          product: new_product.attributes,
          format: 'json'
        )
        expect(response.body).to be_json_success(true)
      end
    end # with valid attributes

    describe 'with invalid attributes' do
      it 'returns a unsuccessful record information' do
        post(
          :create,
          product: {
            name: nil
          },
          format: 'json'
        )
        expect(response.body).to be_json_success(false)
      end
    end
  end
end
