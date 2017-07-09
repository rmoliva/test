# encoding: utf-8
# frozen_string_literal: true

module Services
  module Concerns
    # This module includes all the methods that a services needs to
    # apply an ActsAsApi template
    module ActsAsPaginable
      extend ::ActiveSupport::Concern

      PER_PAGE = 30

      included do
      end

      # This are the Class Methods that this concern extends
      module ClassMethods
      end

      def paginate(scope)
        param_all ? scope.scoped : scope.page(param_page).per(param_per_page)
      end

      protected

      def param_all
        @params[:all].to_i == 1
      end

      def param_page
        @params[:page].blank? ? 1 : @params[:page].to_i
      end

      def param_per_page
        @params[:per_page].blank? ? PER_PAGE : @params[:per_page].to_i
      end
    end
  end
end
