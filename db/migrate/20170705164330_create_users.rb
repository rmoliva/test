# encoding: utf-8
# frozen_string_literal: true

# This migration creates the `users` table
class CreateUsers < ActiveRecord::Migration
  # rubocop:disable Metrics/MethodLength
  def change
    create_table(
      :users
    ) do |t|
      t.string :name, null: false
      t.string :surname

      # Authlogic::ActsAsAuthentic::Email
      t.string :email

      t.string :timezone,      null: false
      t.string :locale,        null: false

      # Authlogic::ActsAsAuthentic::Password
      t.string :crypted_password
      t.string :password_salt

      # Authlogic::ActsAsAuthentic::PersistenceToken
      t.string :persistence_token

      # Authlogic::ActsAsAuthentic::PerishableToken
      t.string :perishable_token

      # Authlogic::Session::MagicColumns
      t.integer  :login_count,        default: 0, null: false
      t.integer  :failed_login_count, default: 0, null: false
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.string   :current_login_ip
      t.string   :last_login_ip

      # Authlogic::Session::MagicStates
      t.boolean :active, default: true

      t.timestamps null: false
    end
    # rubocop:enable Metrics/BlockLength

    add_index :users, %i[name surname]
    add_index :users, :email, unique: true
  end
end
