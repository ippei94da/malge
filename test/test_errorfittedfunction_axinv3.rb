#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "malge.rb"

class TC_ErrorFittedFunction_AXInv3 < Test::Unit::TestCase
  def setup
    @axi301 = Malge::ErrorFittedFunction::AXInv3.new(
      [
        [1.0, 68.0],
        [2.0, 12.0],
        [4.0,  5.0],
        [8.0,  4.0],
      ]
    )
  end

  #def test_initialize
  #end

  def test_equation
    assert_equal("f(x) = 64.000000 / (x^3)", @axi301.equation)
  end

  def test_fit
    assert_equal([64.0], @axi301.coefficients)
  end

  def test_expected_error
    assert_equal(64.0  , @axi301.expected_error(1.0))
    assert_equal( 8.0  , @axi301.expected_error(2.0))
    assert_equal( 1.0  , @axi301.expected_error(4.0))
    assert_equal( 0.125, @axi301.expected_error(8.0))
  end

  def test_finest_y
    assert_equal( 4.0, @axi301.finest_y)
  end

  def test_variance
    assert_equal( 0.0, @axi301.variance)
    #diff_abs = [4,1]
    #expected = [1,3]
  end

  def test_x
    assert_equal(2.0, @axi301.x(8.0))
  end

end

