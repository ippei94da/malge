#! /usr/bin/env ruby
# coding: utf-8

require "test/unit"
require "malge.rb"

TOLERANCE=1.0e-10

class TC_Malge < Test::Unit::TestCase
  #def setup
  #  @k = Malge.new
  #end

  def test_least_square_1st_degree
    data_pairs =
    [
      [-10.000, -12.067],
      [ -9.000, -11.490],
      [ -8.000, -10.034],
      [ -7.000,  -9.196],
      [ -6.000,  -7.571],
      [ -5.000,  -6.606],
      [ -4.000,  -6.299],
      [ -3.000,  -5.004],
      [ -2.000,  -3.858],
      [ -1.000,  -3.497],
      [  0.000,  -2.484],
      [  1.000,  -1.079],
      [  2.000,  -0.425],
      [  3.000,   0.915],
      [  4.000,   2.031],
      [  5.000,   3.438],
      [  6.000,   4.012],
      [  7.000,   5.258],
      [  8.000,   5.695],
      [  9.000,   6.645],
      [ 10.000,   7.962],
    ]
    #should be below, confirmed by Excel.
    a0 = -2.0787619047619
    a1 =  1.00077142857143

    results=Malge::LeastSquare.least_square_1st_degree(data_pairs)
    assert_equal(2, results.size)
    assert_in_delta(a0, results[0], TOLERANCE)
    assert_in_delta(a1, results[1], TOLERANCE)
  end

  def test_least_square_exp
    data_pairs =
    [
      [0.0, 14.0],
      [1.0, 12.0],
      [2.0, 11.0],
    ]
    # y = a e^{bx} + c
    # should be
    # y = 4.0 exp^{- log_e 2 x} + 10
    a0 = 4.0
    a1 = - Math::log(2.0)
    a2 = 10.0

    tolerance0 = 1.0E-5
    results = Malge::LeastSquare.least_square_exp(data_pairs, tolerance0)
    assert_equal(3, results.size)
    tolerance1 = 1.0E-3
    assert_in_delta(a0, results[0], tolerance1)
    assert_in_delta(a1, results[1], tolerance1)
    assert_in_delta(a2, results[2], tolerance1)
  end
end

