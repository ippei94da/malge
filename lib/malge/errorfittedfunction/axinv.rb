#! /usr/bin/env ruby
# coding: utf-8

#Assumed y = a[0] + a[1]/x
#
#NOTE: @coefficients[0] might become negative value.
# Need discussion for dealing?
class Malge::ErrorFittedFunction::AXInv < Malge::ErrorFittedFunction

  def fit
    inv_pairs =  @diff_abs_pairs.map {|pair| [1.0/pair[0], pair[1]]}
    @coefficients = Malge::LeastSquare.least_square_proportional(inv_pairs)
  end

  def expected_error(x)
    @coefficients[0] / x
  end

  #y = a/x
  #x = a/y
  def x(y)
    return @coefficients[0] / y
  end

  def finest_y
    @raw_pairs.max_by { |pair| pair[0] }[1]
  end

end

