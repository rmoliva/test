# encoding: utf-8
# frozen_string_literal: true

module Services
  module Products
    # This is the Products show service
    class Show < Services::ApplicationService
      def initialize(user_session, params)
        @user_session = user_session
        @params = params
      end

      def execute!
        scope.find(@params[:id])
      end

      protected

      def scope
        Product
      end
    end
  end
end
