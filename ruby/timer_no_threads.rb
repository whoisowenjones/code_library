#!/usr/bin/env ruby -wKU

def repeat_every(interval)
  loop do
    start_time = Time.now
    yield
    elapsed = Time.now - start_time
    sleep([interval - elapsed, 0].max)
  end
end

repeat_every(5) do
  puts Time.now.to_i
end
