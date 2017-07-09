# encoding: utf-8
# frozen_string_literal: true

module Concerns
  # This module includes all the methods that a controller needs to
  # check and get the registered user via Authlogic
  module ActsAsJsoner
    extend ::ActiveSupport::Concern

    included do
    end

    # This are the Class Methods that this concern extends
    module ClassMethods
    end

    def json_emitter(service)
      new_params =
        if respond_to?("permit_params_#{params[:action]}")
          send("permit_params_#{params[:action]}", params)
        else
          params
        end
      service_object = service.new(current_user_session, new_params)
      respond_to do |format|
        format.json do
          render json: {
            success: true,
            data: service_object.execute!
          }
          return
        end
      end
    end
  end
end
