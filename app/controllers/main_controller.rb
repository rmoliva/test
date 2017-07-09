# encoding: utf-8
# frozen_string_literal: true

# Main controller class
class MainController < ApplicationController
  skip_filter :require_user_filter, only: %I[index rating]
  before_filter :check_authentication, only: %I[index rating]

  def index; end

  def rating
    service = ::Services::Main::Rating.new(current_user_session, params)
    @products = service.execute!
  end

  protected

  def check_authentication
    redirect_to(new_user_session_path) unless logged_in?
  end
end
