#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "malge.rb"
#require "malge/errorfittedfunction.rb"

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

    ##max
    #finest_pair = @raw_pairs.max_by { |pair| pair[0] }
    #finest_pair[1]

    ##@raw_pairs[x][1]
  end

  def most_strict_condition
    return @raw_pairs.max_by {|pair| pair[1]}
  end

end

class Malge::ErrorFittedFunction::Dummy02 < Malge::ErrorFittedFunction
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
    @coefficients = [0.0/0.0, 1.0]
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

  def test_equation
    assert_raise(Malge::ErrorFittedFunction::NotImplementedError){
      @eff01.equation
    }
  end

  def test_initialize_diff_abs_pairs
    # not ordered.
    data = [
      [1000.0, -3.153327],
      [1200.0, -3.150316],
      [1500.0, -3.151397],
      [ 500.0, -3.11294],
      [ 600.0, -3.181593],
      [ 700.0, -3.165176],
      [ 900.0, -3.152733],
      [ 500.0, -3.11294]
    ]
    aebx02 = Malge::ErrorFittedFunction::Dummy02.new(data)
    pp aebx02.diff_abs_pairs
    assert_equal

    TODO
  end

  def test_most_strict_condition
    TODO
    assert_equal(2.0, @eff01.most_strict_condition)
  end


  def test_initialize
    assert_raise(Malge::ErrorFittedFunction::NotImplementedError){
      Malge::ErrorFittedFunction::Dummy00.new([[0.0, 1.0]])
    }

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

    assert_raise(Malge::ErrorFittedFunction::UnableCalculationError){
      Malge::ErrorFittedFunction::Dummy02.new([[1,2]])
    }
  end

  def test_finest_y
    assert_equal(4.0, @eff01.finest_y)
  end

end

