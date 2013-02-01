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
    #should be below, confirmed by Excel
    a0 = -2.0787619047619
    a1 =  1.00077142857143

    results=Malge::LeastSquare.least_square_1st_degree(data_pairs)
    assert_equal(2, results.size)
    assert_in_delta(a0, results[0], TOLERANCE)
    assert_in_delta(a1, results[1], TOLERANCE)
  end
end

