# encoding: utf-8
# frozen_string_literal: true

module Services
  module Main
    # This is the Rating create service
    class Rating < Services::ApplicationService
      def initialize(user_session, params)
        @user_session = user_session
        @params = params
      end

      def execute!
        scope.all
      end

      protected

      def scope
        Product
      end
    end
  end
end
