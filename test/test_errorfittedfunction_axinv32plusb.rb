#! /usr/bin/env ruby
# coding: utf-8

require "test/unit"
require "malge.rb"
#require "malge/errorfittedfunction.rb"

class TC_ErrorFittedFunction_AXInv32PlusB < Test::Unit::TestCase
  TOLERANCE = 1.0E-10

  def setup
    @axi00 = Malge::ErrorFittedFunction::AXInv32PlusB.new(
      [
        [ 1, 164.0],
        [ 4, 108.0],
        [16, 101.0],
        [64, 100.0],
      ]
    )

    @axi01 = Malge::ErrorFittedFunction::AXInv32PlusB.new(
      [
        [ 1, 164.0],
        [ 4,  92.0],
        [16, 101.0],
        [64, 100.0],
      ]
    )

  end

  #def test_initialize
  #end

  def test_fit
    corrects = [0.0, 64.0]
    results = @axi00.coefficients
    assert_in_delta(corrects[0], results[0], TOLERANCE)
    assert_in_delta(corrects[1], results[1], TOLERANCE)
  end

  def test_expected_error
    assert_equal(64.0, @axi00.expected_error(1.0))
    assert_equal( 8.0, @axi00.expected_error(4.0))
    assert_equal( 1.0, @axi00.expected_error(16.0))

    assert_equal(64.0, @axi01.expected_error(1.0))
    assert_equal( 8.0, @axi01.expected_error(4.0))
    assert_equal( 1.0, @axi01.expected_error(16.0))
  end

  def test_finest_y
    assert_equal(100.0, @axi00.finest_y)
    assert_equal(100.0, @axi01.finest_y)
  end

  def test_variance
    assert_equal( 0.0, @axi00.variance)
    assert_equal( 0.0, @axi01.variance)
  end

  def test_x
    assert_in_delta(16.0, @axi00.x(1.0), TOLERANCE)
  end

end

