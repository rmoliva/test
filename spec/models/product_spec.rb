# encoding: utf-8
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'definition' do
    let(:product) { Product.make! }
    subject { product }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:rating) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_numericality_of(:price) }
    it { is_expected.to validate_numericality_of(:rating).only_integer }
  end # definition
end
