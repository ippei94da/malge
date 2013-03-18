#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "malge.rb"

class TC_ErrorFittedFunction_AXInv2 < Test::Unit::TestCase

  $tolerance = 1E-10

  def setup
    @axi200 = Malge::ErrorFittedFunction::AXInv2.new(
      [
        [1.0,   1.0],
        [2.0**(-1.0/2.0), 3.0],
      ]
    )
  end

  def test_equation
    assert_equal("f(x) = 0.800000 / (x^2)", @axi200.equation)
  end

  def test_fit
    assert_in_delta(0.8, @axi200.coefficients[0], $tolerance)
  end

  def test_expected_error
    assert_in_delta(0.8, @axi200.expected_error(1.0), $tolerance)
    assert_in_delta(1.6, @axi200.expected_error(2.0**(-1.0/2.0)), $tolerance)
  end

  def test_most_strict_pair
    assert_in_delta(  1.0, @axi200.most_strict_pair[0])
    assert_in_delta(  1.0, @axi200.most_strict_pair[1])
  end


  def test_variance
    assert_in_delta( 0.8, @axi200.variance, $tolerance)
  end

  def test_x
    assert_in_delta(1.0, @axi200.x(0.8), $tolerance)
  end


  #def setup
  #  @axi201 = Malge::ErrorFittedFunction::AXInv2.new(
  #    [
  #      [1.0, 20.0],
  #      [2.0,  8.0],
  #      [4.0,  5.0],
  #      [8.0,  4.0],
  #    ]
  #  )
  #end

  ##def test_initialize
  ##end

  #def test_equation
  #  assert_equal("f(x) = 16.000000 / (x^2)", @axi201.equation)
  #end

  #def test_fit
  #  assert_equal([16.0], @axi201.coefficients)
  #end

  #def test_expected_error
  #  assert_equal(16.0 , @axi201.expected_error(1.0))
  #  assert_equal( 4.0 , @axi201.expected_error(2.0))
  #  assert_equal( 1.0 , @axi201.expected_error(4.0))
  #  assert_equal( 0.25, @axi201.expected_error(8.0))
  #end

  #def test_most_strict_y
  #  assert_equal( 4.0, @axi201.most_strict_y)
  #end

  #def test_most_strict_x
  #  assert_equal(8.0, @axi201.most_strict_x)
  #end

  #def test_variance
  #  assert_equal( 0.0, @axi201.variance)
  #  #diff_abs = [4,1]
  #  #expected = [1,3]
  #end

  #def test_x
  #  assert_equal(2.0, @axi201.x(4.0))
  #end

end

