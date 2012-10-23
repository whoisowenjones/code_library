namespace "db" do

  desc "Drop and recreate database"
  task :rebuild => :environment do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
  end

  desc "Dump schema and content"
  task "dump" => :environment do
    rails_env = (Rails.env || 'development')
    app_name = Rails.application.class.parent_name
    config = ActiveRecord::Base.configurations[rails_env]
    if config["adapter"] == "postgresql"
      unless config['password'].nil?
        ENV["PGPASSWORD"] = config['password'].to_s
      end
      `pg_dump -U #{config['username']} #{config['database']} > #{Rails.root}/db/#{app_name}_#{rails_env}.sql`
    elsif config.adapter == ("mysql" || "mysql2")
      `mysqldump -r #{Rails.root}/db/#{app_name}_#{rails_env}.sql #{config['database']} -u #{config['username']} -p#{config['password'].to_s}`
    end
  end

  desc "Restore dev database from SQL file"
  task "restore" => [:environment, "db:rebuild"] do
    rails_env = (Rails.env || 'development')
    app_name = Rails.application.class.parent_name
    config = ActiveRecord::Base.configurations[rails_env]
    # make sure
    if rails_env != 'development'
      puts "This is very destructive. Are you sure? (Type 'yes' or cancel)."
      unless gets.chomp == "yes"
        puts "Aborted. Close call."
        exit
      end
    end

    file_name = "#{app_name}_#{rails_env}.sql"
    sql_file = "db/#{file_name}"

    if File.exist? sql_file

      if config["adapter"] == "postgresql"
        unless config['password'].nil?
          ENV["PGPASSWORD"] = config['password'].to_s
        end
        `psql #{config['database']} -f #{sql_file}`
      elsif config.adapter == ("mysql" || "mysql2")
        `mysql -u #{config['username']} -p#{config['password'].to_s} --default-character-set=utf8 #{config['database']} < #{sql_file}`
      end

      puts "\nThat should do it. Get to work.\n\n"

    else
      puts "No data file in db/ named '#{file_name}'."
    end

  end

end
