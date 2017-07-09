# encoding: utf-8
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::UserSessions::Destroy, type: :model do
  let(:password) { '12345678' }
  let(:user) do
    user = User.make!(
      password: password,
      password_confirmation: password
    )
    user.reset_persistence_token!
    user
  end

  context 'with user logged' do
    let(:user_session) do
      UserSession.create!(
        email: user.email,
        password: password
      )
    end
    let(:power) { Powers::UserSession.new(user_session) }
    let(:service) { Services::UserSessions::Destroy }

    subject do
      service.new(
        power,
        {}
      )
    end

    it 'returns a successful user information' do
      expect(subject.execute!).to eql(user.as_api_response(:base))
    end
  end

  context 'with user not logged' do
    let(:user_session) { nil }
    let(:power) { Powers::UserSession.new(user_session) }
    let(:service) { Services::UserSessions::Destroy }

    subject do
      service.new(
        power,
        {}
      )
    end

    it 'raise an error' do
      expect { subject.execute! }.to raise_error(SecurityError)
    end
  end
end
