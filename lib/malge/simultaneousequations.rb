require 'matrix'

# Solve simultatneous equations with Cramer\'s formula.
#
# if you need to solve simultaneous equations,
# 	(a_11 ... a_1n) (x_1)   (c_1)
# 	(.... ... ....) (...) = (...)
# 	(a_n1 ... a_nn) (x_n)   (c_n)
# command
# % #{$0} a_11 ... a_1n ... a_n1 ... a_nn c_1 ... c_n
# 

class Matrix
	def []=(i,j,x)
		@rows[i][j]=x
	end
end

class Vector
	def []=(i,x)
		@elements[i]=x
	end
end

# 連立1次方程式を表現するクラス。
class SimultaneousEquations
	
	# Solve equation by Cramer's.
	# matrix は2重配列で与える。
	# 返されるのは、解の値を格納した配列。
	def self.cramer( matrix, values )
		matrix = Matrix.rows( matrix )
		raise "Matrix is not squre: #{matrix.row_size} x #{matrix.column_size}." if ( ! matrix.square? )
		raise "Matrix size (#{matrix.row_size}) and values size (#{values.size}) mismatched." if ( matrix.row_size != values.size )
		raise "Matrix is not regular. Degree of freedom is #{matrix.column_size - matrix.rank}.\n" if ( ! matrix.regular? )

		results = Array.new
		n = matrix.column_size
		n.times do |i|
			tmp = Marshal.load( Marshal.dump( matrix ) )
			n.times do |j|
				tmp[ j, i ] = values[ j ]
			end
			results[i] = tmp.determinant / ( matrix.determinant )
		end
		results
	end

	# matrix は左辺の行列、values は右辺の値の配列
	# ともに配列で与える。
	def initialize( matrix, values )
		@matrix = matrix
		@values = values
	end

	# Cramer's formula で解く。
	def cramer
		SimultaneousEquations.cramer( @matrix, @values )
	end

end

