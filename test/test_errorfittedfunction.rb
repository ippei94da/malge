#! /usr/bin/env ruby
# coding: utf-8

require "pp"
require "helper"
#require "test/unit"
#require "malge.rb"
#require "malge/errorfittedfunction.rb"

class Malge::ErrorFittedFunction::Dummy00 < Malge::ErrorFittedFunction
  def fit; end
end

class Malge::ErrorFittedFunction::Dummy01 < Malge::ErrorFittedFunction
  $tolerance = 1E-10

  def expected_error(x)
    @coefficients[0] + @coefficients[1] * x
  end

  #Assume: y = 1.0 + 2.0 * x
  #x = 1/2( y - 1.0)
  def x(y)
    return 1.0/2.0 * (y - 1.0)
  end

  def equation
   "x = 1/2( y - 1.0)"
  end

  #Assume: y = 1.0 + 2.0 * x
  def fit
    @coefficients = [1.0, 2.0]
  end

  def most_strict_pair
    @raw_pairs.max_by{ |pair| pair[0] }
  end

end

## Dummy class to check Exception due to NaN.
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

  def most_strict_pair
    @raw_pairs.max_by { |pair| pair[0] }
  end
end

class Malge::ErrorFittedFunction::Dummy03 < Malge::ErrorFittedFunction
  $tolerance = 1E-10

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

  def most_strict_pair
    @raw_pairs.max_by{ |pair| pair[0] }
  end

end


class TC_ErrorFittedFunction < Test::Unit::TestCase
  def setup
    @eff01 = Malge::ErrorFittedFunction::Dummy01.new(
      [
        [0.0, 0.0],
        [2.0, 4.0],
        [1.0, 5.0],
      ]
    )

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
    @eff02 = Malge::ErrorFittedFunction::Dummy01.new(data)
  end

  def test_variance
    # diff_abs_pairs = [[0.0, 4.0], [1.0, 1.0]
    # function       = 2x + 1
    # Then, 3 **2 + 2**2 = 13
    assert_equal(13.0, @eff01.variance)
  end

  def test_expected_error
    assert_equal(1.0, @eff01.expected_error(0.0))
    assert_equal(3.0, @eff01.expected_error(1.0))
    assert_equal(5.0, @eff01.expected_error(2.0))
  end

  def test_equation
    eff = Malge::ErrorFittedFunction::Dummy03.new(
      [
        [0.0, 0.0],
        [1.0, 5.0],
        [2.0, 4.0],
      ]
    )
    assert_raise(Malge::ErrorFittedFunction::NotImplementedError){
      eff.equation
    }
  end

  def test_initialize_diff_abs_pairs

    assert_equal( 500.0, @eff02.diff_abs_pairs[0][0])
    assert_equal( 500.0, @eff02.diff_abs_pairs[1][0])
    assert_equal( 600.0, @eff02.diff_abs_pairs[2][0])
    assert_equal( 700.0, @eff02.diff_abs_pairs[3][0])
    assert_equal( 900.0, @eff02.diff_abs_pairs[4][0])
    assert_equal(1000.0, @eff02.diff_abs_pairs[5][0])
    assert_equal(1200.0, @eff02.diff_abs_pairs[6][0])

    assert_in_delta(0.038457, @eff02.diff_abs_pairs[0][1], $tolerance)
    assert_in_delta(0.038457, @eff02.diff_abs_pairs[1][1], $tolerance)
    assert_in_delta(0.030196, @eff02.diff_abs_pairs[2][1], $tolerance)
    assert_in_delta(0.013779, @eff02.diff_abs_pairs[3][1], $tolerance)
    assert_in_delta(0.001336, @eff02.diff_abs_pairs[4][1], $tolerance)
    assert_in_delta(0.001930, @eff02.diff_abs_pairs[5][1], $tolerance)
    assert_in_delta(0.001081, @eff02.diff_abs_pairs[6][1], $tolerance)
  end

  def test_most_strict_pair
    assert_equal(2.0, @eff01.most_strict_pair[0])
    assert_equal(4.0, @eff01.most_strict_pair[1])

    assert_equal(1500.0     , @eff02.most_strict_pair[0])
    assert_equal(-3.151397, @eff02.most_strict_pair[1])
  end

  def test_count_equal_under_over
    #pp @eff01
    assert_equal([0, 1, 1], @eff01.count_equal_under_over)
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

  def test_summary
    io = StringIO.new
    @eff01.summary(io)
    io.rewind
    #pp io.readlines
    io.rewind
    assert_equal(
      ["Fitted function: x = 1/2( y - 1.0)\n",
        "              x,           raw_y,   |diff_y_best|,  expected_error\n",
        "   0.0000000000,    0.0000000000,    4.0000000000,    1.0000000000\n",
        "   1.0000000000,    5.0000000000,    1.0000000000,    3.0000000000\n",
        "   2.0000000000,    4.0000000000,    ------------,    5.0000000000\n"
      ],
      io.readlines
    )
  end
end

