# encoding: utf-8
# frozen_string_literal: true

module UserSessions
  # This is the UserSessions::UserProviders class
  class UserProvidersController < UserSessions::ApplicationController
    def destroy
      json_emitter ::Services::UserSessions::UserProviders::Destroy
    end

    protected

    def current_power
      Powers::UserSession.new(current_user_session)
    end
  end
end
