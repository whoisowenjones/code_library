def sudome
  if ENV["USER"] != "root"
    exec("sudo #{ENV['_']} #{ARGV.join(' ')}")
  end
end
