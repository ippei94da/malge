#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "pkg/klass.rb"

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

  def test_abstract
    assert_equal(
      [
        {:a => 0.0, :b => 0.0, :c => 0.0, :z => 0.0 }
      ],
      @mvf00.abstract({:a => 0.0, :b => 0.0, :c => 0.0})
    )

    assert_equal(
      [
        {:a => 0.0, :b => 0.0, :c => 0.0, :z => 0.0 },
        {:a => 0.0, :b => 0.0, :c => 1.0, :z => 1.0 },
      ],
      @mvf00.abstract({:a => 0.0, :b => 0.0})
    )

    assert_equal(
      [
        {:a => 0.0, :b => 0.0, :c => 0.0, :z => 0.0 },
        {:a => 0.0, :b => 0.0, :c => 1.0, :z => 1.0 },
        {:a => 0.0, :b => 1.0, :c => 0.0, :z => 2.0 },
        {:a => 0.0, :b => 1.0, :c => 1.0, :z => 3.0 },
      ],
      @mvf00.abstract({:a => 0.0})
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
      @mvf00.abstract({})
    )

    assert_equal( [], @mvf00.abstract({:a => 2.0}))
  end
end

