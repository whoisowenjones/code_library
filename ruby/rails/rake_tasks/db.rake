namespace "db" do

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

    elsif config['adapter'].to_s == "mysql" or config['adapter'].to_s == "mysql2"

      puts "mysqldump -u #{config['username']} --password=#{config['password'].to_s} #{config['database']} -r #{Rails.root}/db/#{app_name}_#{rails_env}.sql"
      `mysqldump -u #{config['username']} --password=#{config['password'].to_s} #{config['database']} -r #{Rails.root}/db/#{app_name}_#{rails_env}.sql`

    else
      puts "not working because: #{config['adapter']}"
    end
  end

end
