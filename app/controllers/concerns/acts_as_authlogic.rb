# encoding: utf-8
# frozen_string_literal: true

module Concerns
  # This module includes all the methods that a controller needs to
  # check and get the registered user via Authlogic
  module ActsAsAuthlogic
    extend ::ActiveSupport::Concern

    included do
      helper_method :current_user_session, :current_user
      before_filter :require_user_filter
    end

    # This are the Class Methods that this concern extends
    module ClassMethods
    end

    def current_user_session
      @current_user_session ||= UserSession.find
    end

    def current_user_object
      @current_user ||= current_user_session && current_user_session.user
    end

    def current_user
      current_user_audit
    end

    def current_user_audit
      (@current_user_var || current_user_object).try(:login)
    end

    def logged_in?
      !current_user_object.nil?
    end

    def require_user_filter
      raise SecurityError, 'You must be logged in' unless logged_in?
    end

    def require_no_user_filter
      raise Exception, 'You must be logged out' if logged_in?
    end
  end
end
