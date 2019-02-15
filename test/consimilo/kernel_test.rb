require "test_helper"

require 'consimilo/kernel'

module Consimilo
  class KernelTest < Minitest::Test
    def test_kernel_method_for_difference
      assert_equal [], Consimilo([], [])
    end

    def test_kernel_method_for_difference_of_mixed
      assert_equal(
          [[], [:foo, :bar], [], []],
          Consimilo(
              [1, :foo, [42], { foo: 1 }],
              [1, :bar, [42], { foo: 1 }]
          )
      )

      assert_equal(
          { foo: [[:b, :c]], bar: [1, nil], next: [nil, 3] },
          Consimilo(
              { foo: [:a, :b], bar: 1, same: 0 },
              { foo: [:a, :c], next: 3, same: 0 },
              compact: true
          )
      )
    end
  end
end
