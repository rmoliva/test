# encoding: utf-8
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserSessionsController, 'POST #create', type: :controller do
  context 'without a logged user' do
    xit 'should fail'
  end

  let(:password) { '12345678' }
  let(:user) do
    User.make!(
      password: password,
      password_confirmation: password
    )
  end

  context 'with valid credentials' do
    before(:each) do
      user.reset_persistence_token!
    end

    it 'returns a successful user information' do
      post(
        :create,
        user_session: {
          email: user.email,
          password: password
        },
        format: 'json'
      )

      expect(response.body).to be_json_success(true)
    end
  end

  context 'with invalid credentials' do
    before(:each) do
      user.reset_persistence_token!
      user.save!
    end

    it 'shows an error message' do
      post(
        :create,
        user_session: {
          email: user.email,
          password: '65473'
        },
        format: 'json'
      )

      expect(response.body).to be_json_success(false)
    end
  end
end
