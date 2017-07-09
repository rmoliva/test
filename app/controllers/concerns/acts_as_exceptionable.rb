# encoding: utf-8
# frozen_string_literal: true

module Concerns
  # This module includes all the methods that a controller needs to
  # check and get the registered user via Authlogic
  module ActsAsExceptionable
    extend ::ActiveSupport::Concern

    included do
      rescue_from Exception, with: :json_exception # if Rails.env.production?
      rescue_from(
        SecurityError,
        with: :authentication_exception
      )
      rescue_from(
        ActiveRecord::RecordInvalid,
        with: :activercord_recordinvalid
      )
    end

    # This are the Class Methods that this concern extends
    module ClassMethods
    end

    def trace_exception(exception)
      Rails.logger.info "EXCEPTION: #{exception.message}"
      return unless exception.backtrace

      exception.backtrace.each do |line|
        Rails.logger.info line
      end
    end

    def json_exception(exception)
      trace_exception(exception)
      respond_to do |format|
        format.json do
          render json: {
            success: false,
            message: exception.message
          }
        end

        format.html do
          redirect_to '/500.html'
        end
      end
    end

    def authentication_exception(exception)
      trace_exception(exception)
      respond_to do |format|
        format.json do
          render json: {
            success: false,
            message: exception.message
          }, status: 401
        end
        format.html { redirect_to '/500.html' }
      end
    end

    def activercord_recordinvalid(exception)
      # trace_exception(exception)
      respond_to do |format|
        format.json do
          render json: {
            success: false,
            errors: exception.record.errors
          }
        end
      end
    end
  end
end
