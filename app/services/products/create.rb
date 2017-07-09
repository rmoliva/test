# encoding: utf-8
# frozen_string_literal: true

module Services
  module Products
    # This is the Products create service
    class Create < Services::ApplicationService
      def initialize(user_session, params)
        @user_session = user_session
        @params = params
      end

      def execute!
        scope.create!(@params[:product])
      end

      protected

      def scope
        Product
      end
    end
  end
end
