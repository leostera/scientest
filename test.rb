require "date"
require "scientist"

def dummy
  (0...1000).map do |i| i+1 end
  true
end

def science_test
  e = Scientist::Experiment.new("is_science_slow?")
  e.use do dummy end
  e.try do dummy end
  e.run
end

def measure name, block
  start = DateTime.now
  block.call
  finish = DateTime.now
  delta = finish-start
  p [name, start, finish, delta]
end

measure "dummy", method(:dummy)
measure "science", method(:science_test)
