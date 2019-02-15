require "test_helper"

class ConsimiloTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Consimilo::VERSION
  end

  def test_difference_of_empty
    assert_equal([], Consimilo.difference([], []))
  end

  def test_difference_of_equal_flat
    assert_equal([], Consimilo.difference([:foo], [:foo]))
    assert_equal({}, Consimilo.difference({ foo: 1 }, { foo: 1 }))
  end

  def test_difference_of_difference_flat
    assert_equal([[:foo, :bar]], Consimilo.difference([:foo], [:bar]))
    assert_equal({ foo: [1, 2] }, Consimilo.difference({ foo: 1 }, { foo: 2 }))
    assert_equal({ foo: [1, nil], bar: [nil, 1] }, Consimilo.difference({ foo: 1 }, { bar: 1 }))
  end

  def test_difference_of_mixed
    assert_equal(
      [[], [:foo, :bar], [], []],
      Consimilo.difference(
        [1, :foo, [42], { foo: 1 }],
        [1, :bar, [42], { foo: 1 }]
      )
    )

    assert_equal(
      { foo: [[], [:b, :c]], bar: [1, nil], next: [nil, 3] },
      Consimilo.difference(
        { foo: [:a, :b], bar: 1, same: 0 },
        { foo: [:a, :c], next: 3, same: 0 }
      )
    )
  end

  def test_difference_of_mixed_compact
    assert_equal(
        [[:foo, :bar]],
        Consimilo.difference(
          [1, :foo, [42], { foo: 1 }],
          [1, :bar, [42], { foo: 1 }],
          compact: true
        )
    )

    assert_equal(
      { foo: [[:b, :c]], bar: [1, nil], next: [nil, 3] },
      Consimilo.difference(
        { foo: [:a, :b], bar: 1, same: 0 },
        { foo: [:a, :c], next: 3, same: 0 },
        compact: true
      )
    )
  end

  def test_force_array_order
    assert_equal(
      [[1 ,3], [], [3, 1]],
      Consimilo.difference(
        [1, 2, 3],
        [3, 2, 1]
      )
    )
  end

  def test_ignore_array_order
    assert_equal(
        [],
        Consimilo.difference(
          [1, 2, 3],
          [3, 2, 1],
          order: false
        )
    )
  end

  def test_compact
    assert_equal(
      [[1 ,3], [3, 1]],
      Consimilo.difference(
        [1, 2, 3],
        [3, 2, 1],
        compact: true
      )
    )
  end
end
