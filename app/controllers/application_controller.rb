# encoding: utf-8
# frozen_string_literal: true

# Application controller class
class ApplicationController < ActionController::Base
  include Concerns::ActsAsAuthlogic
  include Concerns::ActsAsJsoner
  include Concerns::ActsAsExceptionable
  include Concerns::ActsAsTimezoner

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
end
