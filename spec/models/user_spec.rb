# encoding: utf-8
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'definition' do
    let(:user) { User.make! }
    subject { user }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:surname) }
    it { is_expected.to validate_presence_of(:email) }
    it do
      %w[blah blah@puff].each do |v|
        is_expected.to_not allow_value(v).for(:email)
      end
    end
    it { is_expected.to allow_value('pepe@juan.com').for(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end # definition
end
