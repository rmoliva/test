# encoding: utf-8
# frozen_string_literal: true

# Monkey patch Ruby String class
class String
  # El orden es el siguiente:
  # vocales_mayusculas - consonantes_mayusculas - vocales_minusculas -
  # consonantes_minusculas
  # Sustituye caracteres internacionales por caracteres ansi
  # Esto se utiliza para mejorar la forma de ordenar que tiene
  # Ruby.
  def uncolate
    tr('ÁÉÍÓÚÜÇÑáéíóúüçñºª', 'AEIOUUCNaeiouucn  ').downcase
  end

  def to_boolean(nil_value = false)
    return nil_value if size.zero?
    to_s !~ /no|false|0|off/i
  end
end
