#! /usr/bin/ruby

require "helper"
#require "test/unit"
#require "malge.rb"
##require "malge/simultaneousequations.rb"

class TC_SimultaneousEquations < Test::Unit::TestCase
    $tolerance = 10.0**(-10)
    def setup
        @se00 = Malge::SimultaneousEquations.new(
            [ [ 1.0,    2.0, -3.0 ],
                [ 2.0,  1.0, -2.0 ],
                [ 3.0,  2.0,    1.0 ] ],
            [ 1.0, 2.0, -1.0]
        )

        @se01 = Malge::SimultaneousEquations.new(
            [ [ 1.0,    1.0,    1.0 ],
                [ 0.0,  1.0,    1.0 ],
                [ 0.0,  0.0,    1.0 ] ],
            [ 3.0, 2.0, 1.0]
        )

        #実数の行列を前提としても良さそうだ。
        #@se02 = Malge::SimultaneousEquations.new(
        # [ [ 1,    2, -3 ],
        #       [ 2,    1, -2 ],
        #       [ 3,    2,  1 ] ],
        # [ 1, 2, -1]
        #)

        @se03 = Malge::SimultaneousEquations.new(
            [ [ 1,  1,  1 ],
                [ 0,    1,  1 ],
                [ 0,    0,  1 ] ],
            [ 3, 2, 1]
        )
    end

    def test_self_cramer
        t = Malge::SimultaneousEquations.cramer(
            [ [ 1.0,    2.0, -3.0 ],
                [ 2.0,  1.0, -2.0 ],
                [ 3.0,  2.0,    1.0 ] ],
            [ 1.0, 2.0, -1.0]
        )
        assert_in_delta(    0.714285714285714, t[0], $tolerance )
        assert_in_delta( -1.142857142857143, t[1], $tolerance )
        assert_in_delta( -0.857142857142857, t[2], $tolerance )

        t = Malge::SimultaneousEquations.cramer(
            [ [ 1.0,    1.0,    1.0 ],
                [ 0.0,  1.0,    1.0 ],
                [ 0.0,  0.0,    1.0 ] ],
            [ 3.0, 2.0, 1.0 ]
        )
        assert_in_delta( 1.0, t[0], $tolerance )
        assert_in_delta( 1.0, t[1], $tolerance )
        assert_in_delta( 1.0, t[2], $tolerance )
    end

    def test_cramer
        t = @se00.cramer
        assert_in_delta(    0.714285714285714, t[0], $tolerance )
        assert_in_delta( -1.142857142857143, t[1], $tolerance )
        assert_in_delta( -0.857142857142857, t[2], $tolerance )

        t = @se01.cramer
        assert_in_delta( 1.0, t[0], $tolerance )
        assert_in_delta( 1.0, t[1], $tolerance )
        assert_in_delta( 1.0, t[2], $tolerance )

        #t = @se02.cramer
        #assert_in_delta(    0.714285714285714, t[0], $tolerance )
        #assert_in_delta( -1.142857142857143, t[1], $tolerance )
        #assert_in_delta( -0.857142857142857, t[2], $tolerance )

        t = @se03.cramer
        assert_in_delta( 1.0, t[0], $tolerance )
        assert_in_delta( 1.0, t[1], $tolerance )
        assert_in_delta( 1.0, t[2], $tolerance )

        #assert_raise( ExceptionForMatrix ){
        # Malge::SimultaneousEquations.cramer(
        #       [ [ 1.0,    2.0, -3.0 ],
        #           [ 2.0,  1.0 ],
        #           [ 3.0,  2.0,    1.0 ] ],
        #       [ 1.0, 2.0, -1.0]
        # )
        #}

        assert_raise( RuntimeError ){
            Malge::SimultaneousEquations.cramer(
                [ [ 1.0,    2.0, -3.0 ],
                    [ 2.0,  1.0, -2.0 ],
                    [ 3.0,  2.0,    1.0 ] ],
                [ 1.0, 2.0]
            )
        }

    end

end
