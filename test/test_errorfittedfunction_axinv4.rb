#! /usr/bin/env ruby
# coding: utf-8

require "helper"
#require "test/unit"
#require "malge.rb"

class TC_ErrorFittedFunction_AXInv4 < Test::Unit::TestCase

    $tolerance = 1E-10

    def setup
        @axi400 = Malge::ErrorFittedFunction::AXInv4.new(
            [
                [1.0, 1.0],
                [2.0, 0.0]
            ]
        )
        #square = ((a/16)-0)^2 + (1-a)^2
        #       = a^2/256 + 1 - 2a + a^2
        #       = (257/256) a^2 - 2a + 1
        #       = (257/256) (a^2 - 2(256/257)a)^2 + alpha
        #       = (257/256) (a - (256/257))^2 + beta
        #therefore, a = 256/257
        #256.0/257.0 = 0.99610894941634241245
    end


    def test_equation
        assert_equal("0.996109 / (x**4)", @axi400.equation)
    end

    def test_fit
        assert_in_delta(256.0/257.0, @axi400.coefficients[0], $tolerance)
    end

    def test_expected_error
        assert_in_delta(256.0/257.0, @axi400.expected_error(1.0), $tolerance)
        assert_in_delta((256.0/257.0)/16.0, @axi400.expected_error(2.0), $tolerance)
    end

    def test_most_strict_pair
        assert_in_delta( 2.0, @axi400.most_strict_pair[0])
        assert_in_delta( 0.0, @axi400.most_strict_pair[1])
    end

    def test_variance
        v = (1.0/257.0)**2 + ((256.0/257.0)/16.0)**2
        assert_in_delta( v, @axi400.variance, $tolerance)
    end

    def test_x
        assert_in_delta((256.0/257.0)**(1.0/4.0), @axi400.x(1.0), $tolerance)
    end

end

