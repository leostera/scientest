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

def measure name, block
  start = Time.now.to_f
  block.call
  finish = Time.now.to_f
  finish-start
end

puts "Running 3 tests with factor #{factor}..."

def benchmark tasks
  tasks.map do |t|
    t[:time] = measure t[:name], t[:predicate]
    p t
    t
  end.sort_by do |t|
    t[:time]
  end

  puts ">> Fastest run: "
  p tasks.first
  tasks
end

benchmark [
  {name: :candidate, predicate: -> { science_test dummy, dummy } },
  {name: :candidate_no_try, predicate: -> { science_test dummy } },
  {name: :control, predicate: -> { dummy } }
]
