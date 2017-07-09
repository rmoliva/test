# encoding: utf-8
# frozen_string_literal: true

module Helpers
  module AuthlogicHelper
    def login(user)
      UserSession.create(user)
    end

    # Generates a user and a user_session
    def create_user_session
      password = '12345678'
      user = User.make!(
        password: password,
        password_confirmation: password
      )
      UserSession.create!(
        email: user.email,
        password: password
      )
    end
  end
end
