#! /usr/bin/env ruby
# coding: utf-8

#
#
#
class Malge::MultiVariableFunction
  attr_reader :data

  TOLERANCE = 1E-10

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
  def abstract!(conditions)
    results = @data.select do |coords|
      match_condition?(coords, conditions)
    end
    @data = results
  end

  def abstract(conditions)
    result = Marshal.load(Marshal.dump(self))
    result.abstract!(conditions)
    result
  end

  # unite axes with the same value.
  # keys : [:a, :b]
  # new_key : default is keys[0]
  def unite_axes!(keys, new_key = nil)
    new_key ||= keys[0]
    results = []
    @data.each do |datum|
      new_datum = Marshal.load(Marshal.dump(datum))
      if same?(new_datum, keys)
        val = new_datum[keys[0]]
        keys.each {|key| new_datum.delete(key) }
        new_datum[new_key] = val
        results << new_datum
      end
    end
    @data = results
  end

  def unite_axes(keys, new_key = nil)
    result = Marshal.load(Marshal.dump(self))
    result.unite_axes!(keys, new_key)
    result
  end

  def delete_axis!(axis)
    @data.each do |datum|
      datum.delete axis
    end
  end

  def delete_axis(axis)
    result = Marshal.load(Marshal.dump(self))
    result.delete_axis!(axis)
    result
  end

  # return 2-dimensional array.
  # [
  #   [x0, y0],
  #   [x1, y1],
  #   :
  # ]
  def data_pairs(key0, key1)
    results = []
    @data.each do |datum|
      results << [datum[key0], datum[key1]]
    end
    results
  end

  private

  #if when the same value among keys, return true.
  #if not, return false.
  def same?(datum, keys, tolerance = TOLERANCE)
    ref = datum[keys[0]]
    keys.each do |key|
      return false unless ref.to_f.equal_in_delta?(datum[key].to_f, tolerance)
    end
    return true
  end

  def match_condition?(datum, conditions)
    conditions.each do |key, val|
      return false unless datum[key] == val
    end
  end

end

