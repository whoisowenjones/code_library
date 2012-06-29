#!/usr/bin/env ruby -wKU

def repeat_every(interval)
  Thread.new do
    loop do
      start_time = Time.now
      yield
      elapsed = Time.now - start_time
      sleep([interval - elapsed, 0].max)
    end
  end
end

thread = repeat_every(5) do
  puts Time.now.to_i
end

puts "Doing other stuff..."

thread.join
