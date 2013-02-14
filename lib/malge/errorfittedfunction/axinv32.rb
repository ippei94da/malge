#! /usr/bin/env ruby
# coding: utf-8

#Assumed y = a[0] + a[1]/x^{3/2}
#
#NOTE: @coefficients[0] might become negative value.
# Need discussion for dealing?
class Malge::ErrorFittedFunction::AXInv32 < Malge::ErrorFittedFunction

  def fit
    inv32_pairs =
      @diff_abs_pairs.map {|pair| [1.0/(pair[0] ** (3.0/2.0)), pair[1]]}
    @coefficients = Malge::LeastSquare.least_square_1st_degree(inv32_pairs)
  end

  def expected_error(x)
    @coefficients[0] + @coefficients[1] * (1.0/(x** (3.0/2.0)))
  end

  #        y = a[0] + a[1]/x
  # y - a[0] = a[1]/x
  #        x = a[1] / (y - a[0])
  def x(y)
    return (@coefficients[1] / (y - @coefficients[0])) ** (2.0/3.0)
  end

  def finest_y
    @raw_pairs.max_by { |pair| pair[0] }[1]
  end

end

