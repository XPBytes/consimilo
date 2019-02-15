require 'consimilo'

module Kernel
  # noinspection RubyInstanceMethodNamingConvention
  def Consimilo(left, right, order: true, compact: false)
    ::Consimilo.difference(left, right, order: order, compact: compact)
  end
end
