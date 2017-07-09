# encoding: utf-8
# frozen_string_literal: true

module Services
  module Concerns
    # This module includes the standar methos to use for the index service
    # which includes the follwing behavior:
    # - Paginable
    # - Searchable
    # - Templatable
    module ActsAsIndexable
      extend ::ActiveSupport::Concern

      included do
      end

      # This are the Class Methods that this concern extends
      module ClassMethods
      end

      def indexable(scope)
        # Ver si hay que filtrar
        scope = ransack(scope)

        # Ver si hay que ordenar
        scope = sort(scope)
        {
          total_count: scope.count,
          records: paginate(scope)
        }
      end

      protected

      def use_distinct?
        return false unless @params[:q]
        @params[:q][:distinct].to_s.to_boolean
      end

      def ransack(scope)
        scope.ransack(
          @params[:q]
        ).result(
          distinct: use_distinct?
        )
      end

      def sort(scope)
        return scope unless @params[:order]
        scope.order(@params[:order])
      end
    end
  end
end
