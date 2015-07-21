#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "malge.rb"

class TC_ErrorFittedFunction_AXInv3 < Test::Unit::TestCase

  $tolerance = 1E-10

  def setup
    @axi300 = Malge::ErrorFittedFunction::AXInv3.new(
      [
        [(2.0 ** (-1.0/3.0)), 3.0],
        [(2.0 ** ( 0      )), 1.0],
        [(2.0 ** ( 1.0/3.0)), 1.0],
      ]
    )
  end

  def test_equation
    assert_equal("0.800000 / (x**3)", @axi300.equation)
  end

  def test_fit
    assert_in_delta(0.8, @axi300.coefficients[0], $tolerance)
  end

  def test_expected_error
    assert_in_delta(0.8, @axi300.expected_error(1.0), $tolerance)
    assert_in_delta(1.6, @axi300.expected_error(2.0**(-1.0/3.0)), $tolerance)
  end

  def test_most_strict_pair
    assert_in_delta( (2.0 ** ( 1.0/3.0)), @axi300.most_strict_pair[0])
    assert_in_delta( 1.0, @axi300.most_strict_pair[1])
  end

  def test_variance
    assert_in_delta( 0.8, @axi300.variance, $tolerance)
  end

  def test_x
    assert_in_delta(1.0, @axi300.x(0.8), $tolerance)
  end

end

