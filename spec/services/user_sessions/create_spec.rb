# encoding: utf-8
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::UserSessions::Create, type: :model do
  let(:password) { '12345678' }
  let(:user) do
    user = User.make!(
      password: password,
      password_confirmation: password
    )
    user.reset_persistence_token!
    user
  end
  let(:service) { Services::UserSessions::Create }

  context 'with valid credentials' do
    subject do
      service.new(
        user_session: {
          email: user.email,
          password: password
        }
      )
    end

    it 'returns a successful user information' do
      expect(subject.execute!).to eql(user)
    end
  end

  context 'with invalid credentials' do
    subject do
      service.new(
        user_session: {
          email: user.email,
          password: '5677876'
        }
      )
    end

    it 'raise an error' do
      expect { subject.execute! }.to raise_error(SecurityError)
    end
  end
end
