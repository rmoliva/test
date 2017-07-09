# encoding: utf-8
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductsController, 'GET #index', type: :controller do
  context 'without a logged user' do
    before(:each) do
      get(
        :index,
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

    before(:each) do
      # Asignar el rol de network_products al usuario para que pueda acceder
      # a las cuentas
      Role.make!(
        user: user,
        role: 'network_products'
      )
    end

    it 'returns a successful record information' do
      get(
        :index,
        format: 'json'
      )
      expect(response.body).to be_json_success(true)
    end
  end
end
