#! /usr/bin/env ruby
# coding: utf-8

#
#
#
class Malge::MultiVariableFunction
  attr_reader :data

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
    self.class.new(results)
  end

  # unite axes with the same value.
  # keys : [:a, :b]
  # new_key : default is keys[0]
  def unite_axes(keys, new_key = nil)
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
    self.class.new(results)
  end

  private

  #if when the same value among keys, return true.
  #if not, return false.
  def same?(datum, keys)
    ref = datum[keys[0]]
    keys.each do |key|
      return false unless ref == datum[key]
    end
    return true
  end

  def match_condition?(datum, conditions)
    conditions.each do |key, val|
      return false unless datum[key] == val
    end
  end

end

