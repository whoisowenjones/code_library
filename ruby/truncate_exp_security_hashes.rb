#!/usr/bin/env ruby

USAGE = "USAGE: #{File.basename(__FILE__)} <environment> <path_to_database_file>\n\n"

if ARGV[0].nil?
  unless ARGV[0] == ( "dev" || "prod" || "staging" )
    puts "\nERROR: Must supply environment as 'dev', 'staging' or 'prod'."
    puts "#{USAGE}"
    exit
  end
end

if ARGV[1].nil?
  puts "ERROR: Must supply configuration file path."
  puts "#{USAGE}"
  exit
end

env = ARGV[0]
file_path = ARGV[1]
file = File.new(file_path)
while (line = file.gets)
  if line =~ /\['#{env}'\]\['database'\]/
    puts line
    database_match = line.match(/\W(\w+)\W;$/)
    if database_match.nil? || database_match.length < 2
      ''
    else
      database = database_match[1]
    end
  end
  if line =~ /\['#{env}'\]\['username'\]/
    username_match = line.match(/\W(\w+)\W;$/)
    if username_match.nil? || username_match.length < 2
      ''
    else
      username = username_match[1]
    end
  end
  if line =~ /\['#{env}'\]\['password'\]/
    password_match = line.match(/\W(\w[^'"]+)\W;$/)
    if password_match.nil? || password_match.length < 2
      ''
    else
      password = password_match[1]
    end
  end
end
file.close

#puts "database = #{database}, username = #{username}, password = #{password}"
`mysql -u #{username} -p'#{password}' #{database} -e "truncate table exp_security_hashes"`
