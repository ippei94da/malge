#! /usr/bin/env ruby
#coding: utf-8

require "helper"
#require "test/unit"
#require "malge.rb"

TOLERANCE=1.0e-10

class TC_Malge < Test::Unit::TestCase
  #def setup
  # @k = Malge.new
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

  def test_variance_1st_degree
    data_pairs = [
      [0.0, -1.0],
      [1.0,  2.0],
      [2.0,  3.0],
      [3.0,  2.0],
    ]
    assert_equal( 4.0, Malge::LeastSquare::variance_1st_degree(data_pairs))
  end

  def test_least_square_proportional
    data_pairs =
    [
      [  1.000,  -2.000],
      [  1.000,  -1.000],
    ]
    results = Malge::LeastSquare.least_square_proportional(data_pairs)
    assert_equal(1, results.size)
    assert_in_delta(-1.5, results[0], TOLERANCE)

    data_pairs =
    [
      [  1.000,  0.000],
      [  2.000,  2.000],
    ]
    results = Malge::LeastSquare.least_square_proportional(data_pairs)
    assert_equal(1, results.size)
    assert_in_delta(0.8, results[0], TOLERANCE)

  end


  def test_a_exp_bx
    data_pairs = [
      [0.0, 4.0],
      [1.0, 2.0],
    ]
    #y = a e^{bx}
    #should be
    #y = 4.0 exp^{- log_e 2 x}
    corrects = [ 4.0, - Math::log(2.0)]
    assert_equal(corrects, Malge::LeastSquare.a_exp_bx(data_pairs))

    data_pairs = [
      [0.0, 1.0],
      [1.0, 4.0],
    ]
    #y = a e^{bx}
    #should be
    #y = 4.0 exp^{- log_e 2 x}
    corrects = [ 1.0, 2.0 * Math::log(2.0)]
    assert_equal(corrects, Malge::LeastSquare.a_exp_bx(data_pairs))

    data_pairs = [
      [0.0,  1.0],
      [1.0,  1.0],
    ]
    assert_raise(Malge::LeastSquare::UnableCalculationError){
      Malge::LeastSquare.a_exp_bx(data_pairs)
    }

    data_pairs = [
      [1.0,  1.0],
      [1.0,  2.0],
    ]
    assert_raise(Malge::LeastSquare::UnableCalculationError){
      Malge::LeastSquare.a_exp_bx(data_pairs)
    }
  end

  def test_least_square_a_exp_bx
    data_pairs = [
      [0.0, 4.0],
      [1.0, 2.0],
      [2.0, 1.0],
    ]
    #y = a e^{bx}
    #should be
    #y = 4.0 exp^{- log_e 2 x}
    corrects = [ 4.0, - Math::log(2.0)]
    results = Malge::LeastSquare.least_square_a_exp_bx(data_pairs)
    assert_equal(2          , results.size)
    assert_in_delta(corrects[0], results[0], TOLERANCE)
    assert_in_delta(corrects[1], results[1], TOLERANCE)

    data_pairs = [
      [0.0,  1.0],
      [1.0,  4.0],
      [2.0, 16.0],
    ]
    corrects = [ 1.0, 2.0 * Math::log(2.0)]
    results = Malge::LeastSquare.least_square_a_exp_bx(data_pairs)
    assert_equal(2          , results.size)
    assert_in_delta(corrects[0], results[0], TOLERANCE)
    assert_in_delta(corrects[1], results[1], TOLERANCE)

    data_pairs = [
      [0.0, 16.0],
      [1.0,  4.0],
      [2.0,  0.0],
    ]
    assert_raise(Malge::LeastSquare::UnableCalculationError) do
      Malge::LeastSquare.least_square_a_exp_bx(data_pairs)
    end
  end

end

