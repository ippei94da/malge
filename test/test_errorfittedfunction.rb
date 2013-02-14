#! /usr/bin/env ruby
# coding: utf-8

require "test/unit"
require "malge.rb"
require "malge/errorfittedfunction.rb"

class Malge::ErrorFittedFunction::Dummy00 < Malge::ErrorFittedFunction
  def fit; end
end

class Malge::ErrorFittedFunction::Dummy01 < Malge::ErrorFittedFunction
  def expected_error(x)
    @coefficients[0] + @coefficients[1] * x
  end

  #Assume: y = 1.0 + 2.0 * x
  #x = 1/2( y - 1.0)
  def x(y)
    return 1.0/2.0 * (y - 1.0)
  end

  #Assume: y = 1.0 + 2.0 * x
  def fit
    @coefficients = [1.0, 2.0]
  end

  def finest_y
    #max
    finest_pair = @raw_pairs.max_by { |pair| pair[0] }
    finest_pair[1]

    #@raw_pairs[x][1]
  end

end

class TC_ErrorFittedFunction < Test::Unit::TestCase
  def setup
    #@eff00 = Malge::ErrorFittedFunction::Dummy00.new([], [])
    @eff01 = Malge::ErrorFittedFunction::Dummy01.new(
      #2x+1 = 1, -1 
      #2x+1 = 3, +2 
      #2x+1 = 5, -1 
      #[0.0, 1.0, 2.0],
      #[0.0, 5.0, 4.0]
      [
        [0.0, 0.0],
        [1.0, 5.0],
        [2.0, 4.0],
      ]
    )
  end

  def test_variance
    assert_equal(13.0, @eff01.variance)
    #diff_abs = [4,1]
    #expected = [1,3]
  end

  def test_expected_error
    assert_equal(1.0, @eff01.expected_error(0.0))
    assert_equal(3.0, @eff01.expected_error(1.0))
    assert_equal(5.0, @eff01.expected_error(2.0))
  end

  def test_initialize
    assert_raise(Malge::ErrorFittedFunction::NotImplementedError){
      Malge::ErrorFittedFunction.new([])
    }
    assert_raise(Malge::ErrorFittedFunction::SizeMismatchError){
      Malge::ErrorFittedFunction.new([[1,2], [1,3, 3]])
    }
    assert_raise(Malge::ErrorFittedFunction::TypeError){
      Malge::ErrorFittedFunction.new([2, [1,2,3]])
    }
    assert_raise(Malge::ErrorFittedFunction::TypeError){
      Malge::ErrorFittedFunction.new([[1,2], 1])
    }
  end

  def test_finest_y
    assert_equal(4.0, @eff01.finest_y)
  end

end

