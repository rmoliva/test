# encoding: utf-8
# frozen_string_literal: true

# This is the UserSessionController class
class UserSessionsController < ApplicationController
  skip_filter :require_user_filter, only: %I[new create]
  before_filter :require_no_user_filter, only: [:create]
  # skip_filter :user_can_access, only: [:create, :destroy]

  def new; end

  def create
    service = ::Services::UserSessions::Create.new(
      current_user_session,
      params
    )
    respond_to do |format|
      format.html do
        begin
          service.execute!
          redirect_to(root_path)
        rescue SecurityError => ex
          flash[:notice] = ex.message
          render action: :new
        end
      end
    end
  end

  def destroy
    service = ::Services::UserSessions::Destroy.new(
      current_user_session,
      params
    )
    respond_to do |format|
      format.html do
        service.execute!
        redirect_to root_path
      end
    end
  end

  protected

  def current_power
    Powers::UserSession.new(current_user_session)
  end
end
