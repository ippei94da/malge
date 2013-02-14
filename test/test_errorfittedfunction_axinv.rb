#! /usr/bin/env ruby
# coding: utf-8

require "test/unit"
require "malge.rb"
require "malge/errorfittedfunction.rb"

#class Malge::ErrorFittedFunction::AXInv
#  public :fit
#end

class TC_ErrorFittedFunction_AXInv < Test::Unit::TestCase
  def setup
    @axi01 = Malge::ErrorFittedFunction::AXInv.new(
      #2x+1 = 1, -1 
      #2x+1 = 3, +2 
      #2x+1 = 5, -1 
      #[0.0, 1.0, 2.0],
      #[0.0, 5.0, 4.0]
      [
        [1.0, 8.0],
        [2.0, 6.0],
        [4.0, 5.0],
        [8.0, 4.0],
      ]
    )
  end

  #def test_initialize
  #end

  #def test_fit
  #end

  def test_expected_error
    assert_equal(4.0, @axi01.expected_error(1.0))
    assert_equal(2.0, @axi01.expected_error(2.0))
    assert_equal(1.0, @axi01.expected_error(4.0))
    assert_equal(0.5, @axi01.expected_error(8.0))
  end

  def test_finest_y
    assert_equal(4.0, @axi01.finest_y)
  end

  def test_variance
    assert_equal( 0.0, @axi01.variance)
    #diff_abs = [4,1]
    #expected = [1,3]
  end

  def test_x
    assert_equal(2.0, @axi01.x(2.0))
  end

end

