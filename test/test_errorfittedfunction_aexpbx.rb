#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "malge.rb"
#require "malge/errorfittedfunction.rb"

class Malge::ErrorFittedFunction::AExpBX
  public :fit
end

class TC_ErrorFittedFunction_AExpBX < Test::Unit::TestCase

  TOLERANCE = 1.0E-10

  def setup
    @aebx00 = Malge::ErrorFittedFunction::AExpBX.new(
      [
        [ 0.0, 104.0],
        [ 1.0, 102.0],
        [ 2.0, 101.0],
        [ 3.0, 100.0],
      ]
    )

    @aebx01 = Malge::ErrorFittedFunction::AExpBX.new(
      [
        [ 0.0, 104.0],
        [ 1.0,  98.0],
        [ 2.0, 101.0],
        [ 3.0, 100.0],
      ]
    )
  end

  #def test_initialize
  #end

  def test_equation
    assert_equal("f(x) = 4.000000 * exp(-0.693147 * x)", @aebx00.equation)
  end

  def test_fit
    corrects = [4.0, - Math::log(2.0)]
    results = @aebx00.coefficients
    assert_equal(2, results.size)
    assert_in_delta(corrects[0] , results[0], TOLERANCE)
    assert_in_delta(corrects[1] , results[1], TOLERANCE)

    results = @aebx01.coefficients
    corrects = [4.0, - Math::log(2.0)]
    assert_equal(2, results.size)
    assert_in_delta(corrects[0] , results[0], TOLERANCE)
    assert_in_delta(corrects[1] , results[1], TOLERANCE)
  end

  def test_expected_error
    assert_in_delta(4.0, @aebx00.expected_error(0.0), TOLERANCE)
    assert_in_delta(2.0, @aebx00.expected_error(1.0), TOLERANCE)
    assert_in_delta(1.0, @aebx00.expected_error(2.0), TOLERANCE)
    assert_in_delta(0.5, @aebx00.expected_error(3.0), TOLERANCE)
  end

  def test_most_strict
    assert_in_delta(  3.0, @aebx00.most_strict_pair[0])
    assert_in_delta(100.0, @aebx00.most_strict_pair[1])
  end

  def test_variance
    assert_in_delta( 0.25, @aebx00.variance, TOLERANCE)
    #diff_abs = [4,1]
    #expected = [1,3]
  end

  def test_x
    assert_in_delta(1.0, @aebx00.x(2.0), TOLERANCE)
  end

end

