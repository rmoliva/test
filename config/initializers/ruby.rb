# encoding: utf-8
# frozen_string_literal: true

# Definimos el directorio lib/ruby como lugar donde poner las clases que
# extienden al core de Ruby
Dir[File.join(Rails.root, 'lib', 'ruby', '*.rb')].each { |l| require l }
