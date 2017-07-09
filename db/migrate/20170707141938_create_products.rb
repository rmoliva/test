# encoding: utf-8
# frozen_string_literal: true

# This migration creates the `products` table
class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :name, null: false
      t.float   :price, null: false
      t.integer :rating, null: false, default: 0
      t.timestamps null: false
    end

    add_index :products, [:name], unique: true
    add_index :products, [:number]
    add_index :products, [:rating]
  end
end
