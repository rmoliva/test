# encoding: utf-8
# frozen_string_literal: true

module Services
  module Products
    # This is the Products index service
    class Index < Services::ApplicationService
      include Services::Concerns::ActsAsIndexable

      def initialize(user_session, params)
        @user_session = user_session
        @params = params
      end

      def execute!
        indexable(scope)
      end

      protected

      def scope
        Product
      end
    end
  end
end
