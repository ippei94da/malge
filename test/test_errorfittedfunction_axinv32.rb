#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "malge.rb"

class TC_ErrorFittedFunction_AXInv32 < Test::Unit::TestCase

  $tolerance = 1E-10

  def setup
    @axi3200 = Malge::ErrorFittedFunction::AXInv32.new(
      [
        [1.0, 1.0],
        [2.0, 3.0],
      ]
    )
  end

  def test_equation
    assert_equal("1.777778 / (x**(3/2))", @axi3200.equation)
  end

  def test_fit
    assert_in_delta(16.0/9.0, @axi3200.coefficients[0], $tolerance)
  end

  def test_expected_error
    assert_in_delta(16.0/9.0, @axi3200.expected_error(1.0), $tolerance)
    assert_in_delta(16.0/9.0 * 2.0**(-3.0/2.0), @axi3200.expected_error(2.0), $tolerance)
  end

  def test_most_strict_pair
    assert_in_delta(  2.0, @axi3200.most_strict_pair[0])
    assert_in_delta(  3.0, @axi3200.most_strict_pair[1])
  end

  def test_variance
    assert_equal(36.0/81.0, @axi3200.variance)
  end

  def test_x
    assert_in_delta(1.0, @axi3200.x(16.0/9.0), $tolerance)
  end

end

