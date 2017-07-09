# encoding: utf-8
# frozen_string_literal: true

module Concerns
  # This module includes all the methods that a controller needs to
  # control the User's timezone
  module ActsAsTimezoner
    extend ::ActiveSupport::Concern

    included do
      around_filter :user_time_zone, if: :current_user_object
    end

    # This are the Class Methods that this concern extends
    module ClassMethods
    end

    def user_time_zone(&block)
      timezone = 'Madrid'
      if current_user_object && !current_user_object.timezone.blank?
        timezone = current_user_object.timezone
      end
      Time.use_zone(timezone, &block)
    end
  end
end
