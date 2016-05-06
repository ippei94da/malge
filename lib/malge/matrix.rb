require "matrix"
#require "malge.rb"

class Malge::Matrix < Matrix
  def []=(i,j,x)
    @rows[i][j]=x
  end
end

