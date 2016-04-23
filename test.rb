require "time"
require "scientist"

def factor
  ARGV[0].to_i or 100
end

def dummy
  (0...100000*factor).map(&:next)
end

def science_test use, try=nil
  e = Scientist::Experiment.new("is_science_slow?")
  e.use do use end
  e.try do try end if try
  e.run
end

def measure name, &block
  start = Time.now.to_f
  block.call
  finish = Time.now.to_f
  delta = finish-start
  p [name, start, finish, delta]
  delta
end

p [:name, :start_time, :finish_time, :total_run_time]
measure "science" do science_test dummy, dummy end
measure "science (no_try)" do science_test dummy end
measure "dummy" do dummy end
