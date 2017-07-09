# encoding: utf-8
# frozen_string_literal: true

# Products controller class
class ProductsController < ApplicationController
  def index
    json_emitter ::Services::Products::Index
  end

  def create
    json_emitter ::Services::Products::Create
  end

  def show
    json_emitter ::Services::Products::Show
  end

  def update
    json_emitter ::Services::Products::Update
  end

  def destroy
    json_emitter ::Services::Products::Destroy
  end

  def permit_params_create(params)
    params.permit(:format, product: %i[name price rating])
  end

  def permit_params_update(params)
    params.permit([:id, :format, product: %i[name price rating]])
  end
end
