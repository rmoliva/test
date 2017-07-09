# encoding: utf-8
# frozen_string_literal: true

# Migration for sessions table
class AddSessionsTable < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :session_id, null: false
      t.text :data
      t.timestamps
    end

    add_index :sessions, :session_id, unique: true
    add_index :sessions, :updated_at
  end
end
