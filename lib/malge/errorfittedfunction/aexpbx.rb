#! /usr/bin/env ruby
# coding: utf-8

#Assumed y = a[0] * exp(a[1] *x)
#
#NOTE: @coefficients[0] might become negative value.
# Need discussion for dealing?
#
#NOTE: Zero value for |y - y_last| is simply ignored due to impossible log evaluation.
# 
class Malge::ErrorFittedFunction::AExpBX < Malge::ErrorFittedFunction

  def fit
    inv_pairs =  @diff_abs_pairs.map {|pair|
      x = pair[0]
      y = Math::log(pair[1])
      [x,y]
    }
    inv_pairs.delete_if {|pair| ! pair[1].finite?} 
    @coefficients = Malge::LeastSquare.least_square_1st_degree(inv_pairs)
    @coefficients[0] = Math::exp @coefficients[0]
  end

  def equation
    sprintf("f(x) = %f \* exp(%f \* x)", * @coefficients)
  end

  def expected_error(x)
    @coefficients[0] * Math::exp( @coefficients[1] * x)
  end

  #y = a[0] * exp(a[1] *x)
  #a[0] * exp(a[1] *x) = y
  #exp(a[1] *x) = y/a[0]
  #a[1] *x = log( y/a[0])
  #x = log( y/a[0])/a[1]
  def x(y)
    return Math::log( y / @coefficients[0])/@coefficients[1]
  end

  def most_strict_pair
    @raw_pairs.max_by{ |pair| pair[0] }
  end

end


