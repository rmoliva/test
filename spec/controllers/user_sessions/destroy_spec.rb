# encoding: utf-8
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserSessionsController, 'DELETE #destroy', type: :controller do
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

  before(:each) do
    user.reset_persistence_token!
    login(user)
  end

  it 'returns a successful user information' do
    delete(
      :destroy,
      format: 'json'
    )
    expect(response.body).to be_json_success(true)
  end
end
