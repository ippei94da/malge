#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "malge.rb"

class TC_ErrorFittedFunction_AXInv2 < Test::Unit::TestCase

    $tolerance = 1E-10

    def setup
        @axi200 = Malge::ErrorFittedFunction::AXInv2.new(
            [
                [1.0,       1.0],
                [2.0**(-1.0/2.0), 3.0],
            ]
        )
    end

    def test_equation
        assert_equal("0.800000 / (x**2)", @axi200.equation)
    end

    def test_fit
        assert_in_delta(0.8, @axi200.coefficients[0], $tolerance)
    end

    def test_expected_error
        assert_in_delta(0.8, @axi200.expected_error(1.0), $tolerance)
        assert_in_delta(1.6, @axi200.expected_error(2.0**(-1.0/2.0)), $tolerance)
    end

    def test_most_strict_pair
        assert_in_delta(    1.0, @axi200.most_strict_pair[0])
        assert_in_delta(    1.0, @axi200.most_strict_pair[1])
    end

    def test_variance
        assert_in_delta( 0.8, @axi200.variance, $tolerance)
    end

    def test_x
        assert_in_delta(1.0, @axi200.x(0.8), $tolerance)
    end

end

