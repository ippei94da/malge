#! /usr/bin/env ruby
# coding: utf-8

#
#
#
module Malge::LeastSquare
  # Argument 'data_pairs' should be Array of Array's. For example,
  #   [
  #     [ 1.0, 2.0],
  #     [ 2.0, 4.0],
  #     [ 3.0, 6.0],
  #   ]
  # return values of [a_0, a_1] in y = a_0 x^0 + a_1 x^1.
  # Note that not [a, b] in y = ax + b.
  def self.least_square_1st_degree(data_pairs)
    #pp data_pairs
    a = 0.0 #x^2
    #b = 0.0 #y^2
    c = 0.0 #x^1
    d = 0.0 #x*y
    e = 0.0 #y^1
    n = data_pairs.size
    data_pairs.each do |pairs|
      x = pairs[0].to_f
      y = pairs[1].to_f
      a += x**2
      #b += y**2
      c += x
      d += x*y
      e += y
    end
    a_1 = (n*d - c*e) / (n*a - c**2)
    a_0 = (a*e - c*d) / (n*a - c**2)
    [a_0, a_1]
  end
end

