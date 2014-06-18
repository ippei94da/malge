#! /usr/bin/env ruby
# coding: utf-8

#Assumed y = a[0] * exp(a[1] * (x **{3/2}))
#
#NOTE: @coefficients[0] might become negative value.
# Need discussion for dealing?
class Malge::ErrorFittedFunction::AExpBX32 < Malge::ErrorFittedFunction

  def fit
    inv_pairs =  @diff_abs_pairs.map {|pair|
      x = pair[0] ** (3.0/2.0)
      y = Math::log(pair[1])
      [x,y]
    }
    inv_pairs.delete_if {|pair| ! pair[1].finite?} 
    @coefficients = Malge::LeastSquare.least_square_1st_degree(inv_pairs)
    @coefficients[0] = Math::exp @coefficients[0]
  end

  def equation
    sprintf("%f \* exp(%f \* x**(3/2))", * @coefficients)
  end

  def expected_error(x)
    @coefficients[0] * Math::exp( @coefficients[1] * x **(3.0/2.0))
  end

  #y = a[0] * exp(a[1] *x**(3/2))
  #a[0] * exp(a[1] *x**(3/2)) = y
  #exp(a[1] *x**(3/2)) = y/a[0]
  #a[1] *x**(3/2) = log( y/a[0])
  #x**(3/2) = log( y/a[0])/a[1]
  #x = (log( y/a[0])/a[1])**(2/3)
  def x(y)
    return (Math::log( y / @coefficients[0])/@coefficients[1]) **(2.0/3.0)
  end

  def most_strict_pair
    @raw_pairs.max_by{ |pair| pair[0] }
  end


end


