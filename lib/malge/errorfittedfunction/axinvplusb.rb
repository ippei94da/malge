#! /usr/bin/env ruby
# coding: utf-8

#Assumed y = a[0] + a[1]/x
#
#NOTE: @coefficients[0] might become negative value.
# Need discussion for dealing?
class Malge::ErrorFittedFunction::AXInvPlusB < Malge::ErrorFittedFunction

  def fit
    inv_pairs =  @diff_abs_pairs.map {|pair| [1.0/pair[0], pair[1]]}
    @coefficients = Malge::LeastSquare.least_square_1st_degree(inv_pairs)
  end

  def equation
    sprintf("f(x) = TODO")
  end

  def expected_error(x)
    #@coefficients[0] + @coefficients[1] * x
    @coefficients[0] + @coefficients[1] * (1.0/x)
  end

  #        y = a[0] + a[1]/x
  # y - a[0] = a[1]/x
  #        x = a[1] / (y - a[0])
  def x(y)
    return @coefficients[1] / (y - @coefficients[0])
  end

  def finest_y
    @raw_pairs.max_by { |pair| pair[0] }[1]
  end

end

