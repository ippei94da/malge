#! /usr/bin/env ruby
# coding: utf-8

#Assumed y = a[0]/x
#
class Malge::ErrorFittedFunction::AXInv < Malge::ErrorFittedFunction

  def fit
    inv_pairs = Marshal.load(Marshal.dump(@diff_abs_pairs))
    #inv_pairs.delete([most_strict_x, 0.0])
    inv_pairs.map! {|pair| [1.0/pair[0], pair[1]]}
    @coefficients = Malge::LeastSquare.least_square_proportional(inv_pairs)
  end

  def equation
    sprintf("%f / x", * @coefficients)
  end

  def expected_error(x)
    @coefficients[0] / x
  end

  #y = a/x
  #x = a/y
  def x(y)
    return @coefficients[0] / y
  end

  def most_strict_pair
    @raw_pairs.max_by{ |pair| pair[0] }
  end


end

