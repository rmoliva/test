# encoding: utf-8
# frozen_string_literal: true

# Solo cargar rubocop en entorno de desarrollo
unless Rails.env.production?
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
end
