#! /usr/bin/env ruby
# coding: utf-8

#Assumed y = a[0]/(x**4)
#
class Malge::ErrorFittedFunction::AXInv4 < Malge::ErrorFittedFunction

  def fit
    inv_pairs =  @diff_abs_pairs.map {|pair| [1.0/(pair[0]**4), pair[1]]}
    @coefficients = Malge::LeastSquare.least_square_proportional(inv_pairs)
  end

  def equation
    sprintf("%f / (x**4)", * @coefficients)
  end

  def expected_error(x)
    @coefficients[0] / (x**4)
  end

  #y = a/x
  #x = a/y
  def x(y)
    return (@coefficients[0] / y) ** (1.0/4.0)
  end

  def most_strict_pair
    @raw_pairs.max_by{ |pair| pair[0] }
  end


end

