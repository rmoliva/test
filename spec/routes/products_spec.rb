# encoding: utf-8
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductsController, type: :routing do
  it 'recognizes and generates a route for index' do
    expect(
      get: '/products.json'
    ).to route_to(
      controller: 'products',
      action: 'index',
      format: 'json'
    )
  end

  it 'recognizes and generates a route for create' do
    expect(
      post: '/products.json'
    ).to route_to(
      controller: 'products',
      action: 'create',
      format: 'json'
    )
  end

  it 'recognizes and generates a route for show' do
    expect(
      get: '/products/1.json'
    ).to route_to(
      controller: 'products',
      action: 'show',
      id: '1',
      format: 'json'
    )
  end

  it 'recognizes and generates a route for update' do
    expect(
      put: '/products/1.json'
    ).to route_to(
      controller: 'products',
      action: 'update',
      id: '1',
      format: 'json'
    )
  end

  it 'recognizes and generates a route for destroy' do
    expect(
      delete: '/products/1.json'
    ).to route_to(
      controller: 'products',
      action: 'destroy',
      id: '1',
      format: 'json'
    )
  end
end
