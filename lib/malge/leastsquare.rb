#! /usr/bin/env ruby
#coding: utf-8

#
#
#
module Malge::LeastSquare

  class UnableCalculationError < Exception; end

  #Return values of [a_0, a_1] in y = a_0 x^0 + a_1 x^1.
  #Argument 'data_pairs' should be Array of Array's. For example,
  #  [
  #    [ 1.0, 2.0],
  #    [ 2.0, 4.0],
  #    [ 3.0, 6.0],
  #  ]
  #Note that not [a, b] in y = ax + b.
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

  def self.least_square_proportional(data_pairs)
    a = 0.0 #x^2
    d = 0.0 #x*y
    n = data_pairs.size
    #pp data_pairs
    data_pairs.each do |pairs|
      x = pairs[0].to_f
      y = pairs[1].to_f
      a += x**2
      #b += y**2
      d += x*y
    end
    #raise  if d == 0.0
    d/a
  end

  #Return variance when fitted to y = a_0 x^0 + a_1 x^1.
  #Argument 'data_pairs' should be Array of Array's. For example,
  #  [
  #    [ 1.0, 2.0],
  #    [ 2.0, 4.0],
  #    [ 3.0, 6.0],
  #  ]
  def self.variance_1st_degree(data_pairs)
    coefficients = self.least_square_1st_degree(data_pairs)
    data_pairs.inject(0.0) do |sum, pair|
      #pp pair
      #pp sum
      x = pair[0]
      y = pair[1]
      f_x = coefficients[0] + coefficients[1] * x
      sum += (y - f_x)**2
    end
  end

  #Return fitted values of [a, b] in a e^{bx} from 2 point data_pairs;
  # [[x0, y0], [x1, y1]]
  #Argument 'data_pairs' should have two items.
  #Raise if including the same data.
  def self.a_exp_bx(data_pairs)
    raise UnableCalculationError if data_pairs[0][1] == data_pairs[1][1]
    raise UnableCalculationError if data_pairs[0][0] == data_pairs[1][0]
    matrix = data_pairs.map { |pair| [1.0, pair[0]] }
    values = data_pairs.map { |pair| Math::log pair[1] }
    coefficients = Malge::SimultaneousEquations.cramer( matrix, values )
    coefficients[0] = Math::exp coefficients[0]
    coefficients
  end

  #Return fitted values of [a, b] in a e^{bx} from more than two data points.
  #Argument 'data_pairs' should be Array of Array's. For example,
  #  [
  #    [ 1.0, 2.0],
  #    [ 2.0, 4.0],
  #    [ 3.0, 6.0],
  #  ]
  def self.least_square_a_exp_bx(data_pairs)
    data_pairs.each do |pair|
      raise UnableCalculationError if pair[1] == 0.0
    end
    data_pairs = data_pairs.map do |pair|
      [pair[0], Math::log(pair[1])]
    end
    coefficients = self.least_square_1st_degree(data_pairs)
    [Math::exp(coefficients[0]), coefficients[1]]
  end

end

