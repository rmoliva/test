# encoding: utf-8
# frozen_string_literal: true

# This is the ActiveRecord model of an Product
class Product < ActiveRecord::Base
  has_paper_trail

  # Relations

  # Attributes

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: true
  validates :rating, presence: true, numericality: { only_integer: true }
end
