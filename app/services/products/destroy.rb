# encoding: utf-8
# frozen_string_literal: true

module Services
  module Products
    # This is the Products destroy service
    class Destroy < Services::ApplicationService
      def initialize(user_session, params)
        @user_session = user_session
        @params = params
      end

      def execute!
        product = scope.find(@params[:id])
        product.destroy
        product
      end

      protected

      def scope
        Product
      end
    end
  end
end
