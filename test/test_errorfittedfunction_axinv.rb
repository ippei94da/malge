#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "malge.rb"
#require "malge/errorfittedfunction.rb"

class TC_ErrorFittedFunction_AXInv < Test::Unit::TestCase

  $tolerance = 1E-10

  def setup
    @axi00 = Malge::ErrorFittedFunction::AXInv.new(
      [
        [1.0, 1.0],
        [0.5, 3.0],
      ]
    )
  end

  def test_equation
    assert_equal("f(x) = 0.800000 / x", @axi00.equation)
  end

  def test_fit
    assert_in_delta(0.8, @axi00.coefficients[0], $tolerance)
  end

  def test_expected_error
    assert_in_delta(0.8, @axi00.expected_error(1.0), $tolerance)
    assert_in_delta(0.4, @axi00.expected_error(2.0), $tolerance)

  end

  def test_most_strict_pair
    assert_in_delta(  1.0, @axi00.most_strict_pair[0])
    assert_in_delta(  1.0, @axi00.most_strict_pair[1])
  end


  def test_variance
    assert_equal( 0.8, @axi00.variance)
  end

  def test_x
    assert_in_delta(1.0, @axi00.x(0.8), $tolerance)
  end

end

