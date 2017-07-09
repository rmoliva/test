# encoding: utf-8
# frozen_string_literal: true

module UserSessions
  # This is the UserSessions::Users class
  class UsersController < UserSessions::ApplicationController
    # Como el create es para registrar, no lo debe hacer alguien
    # que ya esta logeado
    skip_filter :require_user_filter, only: [:create]
    before_filter :require_no_user_filter, only: [:create]

    # Devuelve los datos del usuario logeado
    def show
      json_emitter ::Services::UserSessions::Users::Show
    end

    def create
      # Registrar un usuario nuevo en el sistema con password
      # y sin proveedor externo
      json_emitter ::Services::UserSessions::Users::Create
    end

    def update
      json_emitter ::Services::UserSessions::Users::Update
    end

    def permit_params_create(params)
      params.permit(
        [
          {
            user: %i[name surname gender email password password_confirmation]
          }
        ]
      )
    end

    def permit_params_update(params)
      params.permit(
        [
          {
            user: %i[
              name surname gender email address city state postal_code phone1
              phone2 password password_confirmation timezone locale
            ]
          }
        ]
      )
    end

    protected

    def current_power
      Powers::UserSession.new(current_user_session)
    end
  end
end
