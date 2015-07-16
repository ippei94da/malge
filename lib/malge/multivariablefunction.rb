#! /usr/bin/env ruby
# coding: utf-8

#
#
#
class Malge::MultiVariableFunction
  #
  # data example:
  #   [
  #     {x => 0.0, y => 0.1, z => 0.0},
  #     {x => 1.0, y => 1.1, z => 1.0},
  #     {x => 2.0, y => 2.1, z => 3.0},
  #   ]
  #
  def initialize(data)
    @data = data
  end

  # Return array of data which matches the hash.
  def abstract(conditions)
    results = @data.select do |coords|
      match_condition?(coords, conditions)
    end
    results
  end

  private

  def match_condition?(datum, conditions)
    conditions.each do |key, val|
      return false unless datum[key] == val
    end
  end

end

