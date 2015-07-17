#! /usr/bin/env ruby
# coding: utf-8

require "helper"
require "pp"
#require "test/unit"
#require "pkg/klass.rb"


class Malge::MultiVariableFunction
  public :same?
end

class TC_MultiVariableFunction < Test::Unit::TestCase
  def setup
    @mvf00 = Malge::MultiVariableFunction.new(
      [
        {:a => 0.0, :b => 0.0, :c => 0.0, :z => 0.0 },
        {:a => 0.0, :b => 0.0, :c => 1.0, :z => 1.0 },
        {:a => 0.0, :b => 1.0, :c => 0.0, :z => 2.0 },
        {:a => 0.0, :b => 1.0, :c => 1.0, :z => 3.0 },
        {:a => 1.0, :b => 0.0, :c => 0.0, :z => 4.0 },
        {:a => 1.0, :b => 0.0, :c => 1.0, :z => 5.0 },
        {:a => 1.0, :b => 1.0, :c => 0.0, :z => 6.0 },
        {:a => 1.0, :b => 1.0, :c => 1.0, :z => 7.0 },
      ]
    )
  end

  def test_abstract!
    @mvf00.abstract!({:a => 0.0, :b => 0.0, :c => 0.0})
    assert_equal(
      [
        {:a => 0.0, :b => 0.0, :c => 0.0, :z => 0.0 }
      ],
      @mvf00.data
    )
  end

  def test_abstract
    assert_equal(
      [
        {:a => 0.0, :b => 0.0, :c => 0.0, :z => 0.0 }
      ],
      @mvf00.abstract({:a => 0.0, :b => 0.0, :c => 0.0}).data
    )
    #check not destructive.
    assert_equal(
      [
        {:a => 0.0, :b => 0.0, :c => 0.0, :z => 0.0 },
        {:a => 0.0, :b => 0.0, :c => 1.0, :z => 1.0 },
        {:a => 0.0, :b => 1.0, :c => 0.0, :z => 2.0 },
        {:a => 0.0, :b => 1.0, :c => 1.0, :z => 3.0 },
        {:a => 1.0, :b => 0.0, :c => 0.0, :z => 4.0 },
        {:a => 1.0, :b => 0.0, :c => 1.0, :z => 5.0 },
        {:a => 1.0, :b => 1.0, :c => 0.0, :z => 6.0 },
        {:a => 1.0, :b => 1.0, :c => 1.0, :z => 7.0 },
      ],
      @mvf00.data
    )

    assert_equal(
      [
        {:a => 0.0, :b => 0.0, :c => 0.0, :z => 0.0 },
        {:a => 0.0, :b => 0.0, :c => 1.0, :z => 1.0 },
      ],
      @mvf00.abstract({:a => 0.0, :b => 0.0}).data
    )

    assert_equal(
      [
        {:a => 0.0, :b => 0.0, :c => 0.0, :z => 0.0 },
        {:a => 0.0, :b => 0.0, :c => 1.0, :z => 1.0 },
        {:a => 0.0, :b => 1.0, :c => 0.0, :z => 2.0 },
        {:a => 0.0, :b => 1.0, :c => 1.0, :z => 3.0 },
      ],
      @mvf00.abstract({:a => 0.0}).data
    )

    assert_equal(
      [
        {:a => 0.0, :b => 0.0, :c => 0.0, :z => 0.0 },
        {:a => 0.0, :b => 0.0, :c => 1.0, :z => 1.0 },
        {:a => 0.0, :b => 1.0, :c => 0.0, :z => 2.0 },
        {:a => 0.0, :b => 1.0, :c => 1.0, :z => 3.0 },
        {:a => 1.0, :b => 0.0, :c => 0.0, :z => 4.0 },
        {:a => 1.0, :b => 0.0, :c => 1.0, :z => 5.0 },
        {:a => 1.0, :b => 1.0, :c => 0.0, :z => 6.0 },
        {:a => 1.0, :b => 1.0, :c => 1.0, :z => 7.0 },
      ],
      @mvf00.abstract({}).data
    )

    assert_equal( [], @mvf00.abstract({:a => 2.0}).data)
  end

  def test_unite_axes!
    @mvf00.unite_axes!([:a, :b, :c])
    assert_equal(
      [
        {:a => 0.0, :z => 0.0 },
        {:a => 1.0, :z => 7.0 },
      ],
      @mvf00.data
    )
  end

  def test_unite_axes
    assert_equal(
      [
        {:a => 0.0, :z => 0.0 },
        {:a => 1.0, :z => 7.0 },
      ],
      @mvf00.unite_axes([:a, :b, :c]).data
    )
    #check not destructive.
    assert_equal(
      [
        {:a => 0.0, :b => 0.0, :c => 0.0, :z => 0.0 },
        {:a => 0.0, :b => 0.0, :c => 1.0, :z => 1.0 },
        {:a => 0.0, :b => 1.0, :c => 0.0, :z => 2.0 },
        {:a => 0.0, :b => 1.0, :c => 1.0, :z => 3.0 },
        {:a => 1.0, :b => 0.0, :c => 0.0, :z => 4.0 },
        {:a => 1.0, :b => 0.0, :c => 1.0, :z => 5.0 },
        {:a => 1.0, :b => 1.0, :c => 0.0, :z => 6.0 },
        {:a => 1.0, :b => 1.0, :c => 1.0, :z => 7.0 },
      ],
      @mvf00.data
    )

    assert_equal(
      [
        {:ab => 0.0, :c => 0.0, :z => 0.0 },
        {:ab => 0.0, :c => 1.0, :z => 1.0 },
        {:ab => 1.0, :c => 0.0, :z => 6.0 },
        {:ab => 1.0, :c => 1.0, :z => 7.0 },
      ],
      @mvf00.unite_axes([:a, :b], :ab).data
    )

    assert_equal(
      [
        {:a => 0.0, :c => 0.0, :z => 0.0 },
        {:a => 0.0, :c => 1.0, :z => 1.0 },
        {:a => 1.0, :c => 0.0, :z => 6.0 },
        {:a => 1.0, :c => 1.0, :z => 7.0 },
      ],
      @mvf00.unite_axes([:a, :b]).data
    )
  end


  def test_same?
    assert_equal(
      true,
      @mvf00.same?({:a => 0.0, :b => 0.0, :c => 0.0, :z => 0.0 }, [:a, :b])
    )

    assert_equal(
      true,
      @mvf00.same?({:a => 0.0, :b => 0.0, :c => 1.0, :z => 1.0 }, [:a, :b])
    )
    assert_equal(
      false,
      @mvf00.same?({:a => 0.0, :b => 1.0, :c => 0.0, :z => 2.0 }, [:a, :b])
    )
    assert_equal(
      false,
      @mvf00.same?({:a => 0.0, :b => 1.0, :c => 1.0, :z => 3.0 }, [:a, :b])
    )
    assert_equal(
      false,
      @mvf00.same?({:a => 1.0, :b => 0.0, :c => 0.0, :z => 4.0 }, [:a, :b])
    )
    assert_equal(
      false,
      @mvf00.same?({:a => 1.0, :b => 0.0, :c => 1.0, :z => 5.0 }, [:a, :b])
    )
    assert_equal(
      true,
      @mvf00.same?({:a => 1.0, :b => 1.0, :c => 0.0, :z => 6.0 }, [:a, :b])
    )
    assert_equal(
      true,
      @mvf00.same?({:a => 1.0, :b => 1.0, :c => 1.0, :z => 7.0 }, [:a, :b])
    )


    # equal in float
    assert_equal(
      true,
      @mvf00.same?({:a => 1E-15, :b => 0.0, :c => 0.0, :z => 0.0 }, [:a, :b])
    )

  end

  def test_delete_axis!
    @mvf00.delete_axis!(:a)
    assert_equal(
      [
        {:b => 0.0, :c => 0.0, :z => 0.0 },
        {:b => 0.0, :c => 1.0, :z => 1.0 },
        {:b => 1.0, :c => 0.0, :z => 2.0 },
        {:b => 1.0, :c => 1.0, :z => 3.0 },
        {:b => 0.0, :c => 0.0, :z => 4.0 },
        {:b => 0.0, :c => 1.0, :z => 5.0 },
        {:b => 1.0, :c => 0.0, :z => 6.0 },
        {:b => 1.0, :c => 1.0, :z => 7.0 },
      ],
      @mvf00.data
    )
  end

  def test_delete_axis
    result = @mvf00.delete_axis(:a)
    assert_equal(
      [
        {:b => 0.0, :c => 0.0, :z => 0.0 },
        {:b => 0.0, :c => 1.0, :z => 1.0 },
        {:b => 1.0, :c => 0.0, :z => 2.0 },
        {:b => 1.0, :c => 1.0, :z => 3.0 },
        {:b => 0.0, :c => 0.0, :z => 4.0 },
        {:b => 0.0, :c => 1.0, :z => 5.0 },
        {:b => 1.0, :c => 0.0, :z => 6.0 },
        {:b => 1.0, :c => 1.0, :z => 7.0 },
      ],
      result.data
    )

    assert_equal(
      [
        {:a => 0.0, :b => 0.0, :c => 0.0, :z => 0.0 },
        {:a => 0.0, :b => 0.0, :c => 1.0, :z => 1.0 },
        {:a => 0.0, :b => 1.0, :c => 0.0, :z => 2.0 },
        {:a => 0.0, :b => 1.0, :c => 1.0, :z => 3.0 },
        {:a => 1.0, :b => 0.0, :c => 0.0, :z => 4.0 },
        {:a => 1.0, :b => 0.0, :c => 1.0, :z => 5.0 },
        {:a => 1.0, :b => 1.0, :c => 0.0, :z => 6.0 },
        {:a => 1.0, :b => 1.0, :c => 1.0, :z => 7.0 },
      ],
      @mvf00.data
    )
  end

  def test_data_pairs
    result = @mvf00.data_pairs(:a, :z)
    assert_equal(
      [
        [0.0, 0.0 ],
        [0.0, 1.0 ],
        [0.0, 2.0 ],
        [0.0, 3.0 ],
        [1.0, 4.0 ],
        [1.0, 5.0 ],
        [1.0, 6.0 ],
        [1.0, 7.0 ],
      ],
      result
    )

  end

end

