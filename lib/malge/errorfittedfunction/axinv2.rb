#! /usr/bin/env ruby
# coding: utf-8

#Assumed y = a[0] /(x^2)
#
class Malge::ErrorFittedFunction::AXInv2 < Malge::ErrorFittedFunction

  def fit
    inv_pairs =  @diff_abs_pairs.map {|pair| [1.0/(pair[0]**2), pair[1]]}
    @coefficients = Malge::LeastSquare.least_square_proportional(inv_pairs)
  end

  def expected_error(x)
    @coefficients[0] / (x**2)
  end

  #y = a/x
  #x = a/y
  def x(y)
    return Math::sqrt(@coefficients[0] / y)
  end

  def finest_y
    @raw_pairs.max_by { |pair| pair[0] }[1]
  end

end

