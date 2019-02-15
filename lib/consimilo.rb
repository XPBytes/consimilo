
module Consimilo
  VERSION = '0.1.0'

  class Error < StandardError; end

  module_function

  def is_array?(instance)
    instance.is_a?(Array)
  end

  def is_hash?(instance)
    instance.is_a?(Hash)
  end

  def difference(left, right, order: true, compact: false)
    if is_array?(left) && is_array?(right)
      result = difference_array(left, right, order: order, compact: compact)
      return result.flatten.empty? ? [] : result
    end

    if is_hash?(left) && is_hash?(right)
      return difference_hash(left, right, order: order, compact: compact)
    end

    [left, right]
  end

  def difference_hash(left, right, order: true, compact: false)
    (left.keys | right.keys).each_with_object({}) do |key, diff|
      next if left[key] == right[key]
      difference = difference(left[key], right[key], order: order, compact: compact)
      next if difference.empty?
      diff[key] = difference
    end
  end

  def difference_array(left, right, order: true, compact: false)
    unless order
      left = left.sort
      right = right.sort
    end

    (0...[left.size, right.size].max).each_with_object([]) do |index, diff|
      if left[index] == right[index]
        next compact ? diff : diff.push([])
      end

      difference = difference(left[index], right[index], order: order, compact: compact)
      next diff if difference.empty? && compact
      diff.push(difference)
    end
  end
end
