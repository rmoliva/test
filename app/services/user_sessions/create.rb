# encoding: utf-8
# frozen_string_literal: true

module Services
  module UserSessions
    # This is the user_session create service class
    class Create
      # Unused method argument - power. If it's necessary, use _ or _power
      # as an argument name to indicate that it won't be used
      def initialize(_, params)
        @params = ActiveSupport::HashWithIndifferentAccess.new(params)
      end

      def execute!
        user_session = UserSession.new(@params[:user_session])
        Rails.logger.info '1Service'

        unless user_session.save
          raise(
            SecurityError,
            I18n.t('user_sessions.invalid_credentials')
          )
        end

        Rails.logger.ap UserSession.find
        Rails.logger.info '2Service'

        user_session.user
      end
    end
  end
end
