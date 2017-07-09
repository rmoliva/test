# encoding: utf-8
# frozen_string_literal: true

# An implementation of the moize pattern
class Memoize
  class << self
    def memoize(collector, *args)
      collector ||= {}
      collector[args] ||= yield
      collector[args]
    end
  end
end
