#! /usr/bin/env ruby
#coding: utf-8

#Class for function to which x[i] and y[i] fit.
#This class include mathematical dealing for errors.
#Not simple fitting;
#this class assume true value with the expected most precise value and
#use absolute value of difference between a data point and the assumed true value.
class Malge::ErrorFittedFunction
    attr_reader :coefficients, :raw_pairs, :diff_abs_pairs

    class TypeError < Exception; end
    class SizeMismatchError < Exception; end
    class NotImplementedError < Exception; end
    class UnableCalculationError < Exception; end

    #Generate error fitted function from x[i] and y[i].
    #Errors are generated y[i] and y_true assumed by the expected most precise y[i].
    def initialize(data_pairs)

        raise TypeError unless data_pairs.class == Array
        data_pairs.each do |pair|
            raise TypeError unless pair.class == Array
            raise SizeMismatchError unless pair.size == 2
        end

        @raw_pairs = data_pairs
        most_strict_x = most_strict_pair[0]
        tmp_pairs = Marshal.load(Marshal.dump( data_pairs))
        tmp_pairs.delete_if {|pair| pair[0] == most_strict_x}

        @diff_abs_pairs = tmp_pairs.map { |pair| [pair[0], (pair[1] - most_strict_pair[1]).abs] }
        fit

        @coefficients.each do |coef|
            raise UnableCalculationError unless coef.finite?
        end
    end

    #Return string which is easily readable for people to know the function.
    def equation
        raise NotImplementedError, "Define #{__method__}() in the inherited class."
    end

    #Return expected error at x, condition variable, on the fitted function.
    #Note that this method does not return the error between actual and true value.
    def expected_error(x)
        raise NotImplementedError, "Define #{__method__}() in the inherited class."
    end

    #Return variance of distribution between each pair
    #of expected error and y[i], actual data point.
    #Note that this method does not return variance of difference
    #between each pair of TRUE value and y[i].
    #Ignore last value of x[i] and y[i].
    def variance
        sum = 0.0
        @diff_abs_pairs.each do |pair|
            #pp pair
            sum += (pair[1] - expected_error(pair[0]) )**2
        end
        sum
    end

    #Return value of 'x', assumed condition value, correspond to extpected value of 'y'.
    def x(y)
        raise NotImplementedError, "Define #{__method__}() in the inherited class."
    end

    #Return the value of y[i] at which the most precise data is expected to be obtained.
    def most_strict_pair
        raise NotImplementedError, "Define #{__method__}() in the inherited class."

        #In the most case, it would be sufficient to select belows.
        @raw_pairs.max_by{ |pair| pair[0] }
        @raw_pairs.mix_by{ |pair| pair[0] }
    end

    # Compare expected error and @raw_pairs and
    # return a count of estimations of [equal, over, under].
    # (order is like as result of <=>. )
    # Excluding last data.
    def count_equal_under_over
        results = [0,0,0]
        @diff_abs_pairs.each do |x,y|
            #pp expected_error(x)
            #pp y
            results[expected_error(x) <=> y ] += 1
        end
        results
    end

    private

    #Fit the data pairs to a certain function.
    #Call from initalize().
    #You need to design to set @coefficients.
    def fit
        #raise NotImplementedError, "Define fit() in the inherited class."
        raise NotImplementedError, "Define #{__method__}() in the inherited class."
    end

end

