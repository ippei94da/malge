#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "malge.rb"
##require "malge/errorfittedfunction.rb"

class Malge::ErrorFittedFunction::AExpBX32
    public :fit
end

class TC_ErrorFittedFunction_AExpBX32 < Test::Unit::TestCase
    TOLERANCE = 1.0E-09 #very large error in calculation at x()
    def setup
        @aebx00 = Malge::ErrorFittedFunction::AExpBX32.new(
            [
                [ 0.0, 100.0 + 3.0* 2.0**(-2.0 *    0        )],
                [ 1.0, 100.0 + 3.0* 2.0**(-2.0 * 1.0    ) ],
                [ 2.0, 100.0 + 3.0* 2.0**(-2.0 * (2.0**(3.0/2.0)))],
                [ 3.0, 100.0                     ],
            ]
        )

        @aebx01 = Malge::ErrorFittedFunction::AExpBX32.new(
            [
                [ 0.0, 100.0 + 3.0* 2.0**(-2.0 *    0        )],
                [ 1.0, 100.0 - 3.0* 2.0**(-2.0 * 1.0    ) ],
                [ 2.0, 100.0 + 3.0* 2.0**(-2.0 * (2.0**(3.0/2.0)))],
                [ 3.0, 100.0                     ],
            ]
        )
    end

    #def test_initialize
    #end

    def test_equation
        assert_equal("3.000000 * exp(-1.386294 * x**(3.0/2.0))", @aebx00.equation)
    end


    def test_fit
        corrects = [3.0, - 2.0*Math::log(2.0)]
        results = @aebx00.coefficients
        assert_equal(2, results.size)
        assert_in_delta(corrects[0] , results[0], TOLERANCE)
        assert_in_delta(corrects[1] , results[1], TOLERANCE)

        corrects = [3.0, - 2.0*Math::log(2.0)]
        results = @aebx01.coefficients
        assert_equal(2, results.size)
        assert_in_delta(corrects[0] , results[0], TOLERANCE)
        assert_in_delta(corrects[1] , results[1], TOLERANCE)
    end

    def test_expected_error
        corrects =
            [
                3.0* 2.0**(-2.0 * 0.0),
                3.0* 2.0**(-2.0 * 1.0),
                3.0* 2.0**(-2.0 * (2.0**(3.0/2.0)))
            ]
        assert_in_delta(corrects[0], @aebx00.expected_error(0.0), TOLERANCE)
        assert_in_delta(corrects[1], @aebx00.expected_error(1.0), TOLERANCE)
        assert_in_delta(corrects[2], @aebx00.expected_error(2.0), TOLERANCE)

        corrects =
            [
                3.0* 2.0**(-2.0 * 0.0),
                3.0* 2.0**(-2.0 * 1.0),
                3.0* 2.0**(-2.0 * (2.0**(3.0/2.0)))
            ]
        assert_in_delta(corrects[0], @aebx01.expected_error(0.0), TOLERANCE)
        assert_in_delta(corrects[1], @aebx01.expected_error(1.0), TOLERANCE)
        assert_in_delta(corrects[2], @aebx01.expected_error(2.0), TOLERANCE)

    end

    def test_most_strict_pair
        assert_in_delta(    3.0, @aebx00.most_strict_pair[0])
        assert_in_delta(100.0, @aebx00.most_strict_pair[1])
    end

    def test_variance
        correct = ( 3.0* 2.0**(-2.0 * (3.0**(3.0/2.0))))**2.0
        assert_in_delta(correct, @aebx00.variance, TOLERANCE)
        assert_in_delta(correct, @aebx01.variance, TOLERANCE)
    end

    def test_x
        assert_in_delta(0.0, @aebx00.x(3.00), TOLERANCE)
        assert_in_delta(1.0, @aebx00.x(0.75), TOLERANCE)
        assert_in_delta(0.0, @aebx01.x(3.00), TOLERANCE)
        assert_in_delta(1.0, @aebx01.x(0.75), TOLERANCE)
    end

end

