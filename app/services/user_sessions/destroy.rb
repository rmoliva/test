# encoding: utf-8
# frozen_string_literal: true

module Services
  module UserSessions
    # This is the UserSessions destroy service
    class Destroy
      def initialize(user_session, params)
        @user_session = user_session
        @params = params
      end

      def execute!
        raise SecurityError, 'Invalid login' unless @user_session
        user = @user_session.user
        @user_session.destroy
        user
      end
    end
  end
end
