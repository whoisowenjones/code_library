namespace "db" do
  desc "Dump schema and content"
  task "dump" => :environment do
    rails_env = (Rails.env || 'development')
    config = ActiveRecord::Base.configurations[rails_env]
    if config["adapter"] == "postgresql"
      unless config['password'].nil?
        puts "Your password is: #{config['password']}"
      end
      #`pg_dump -U #{config['user']} #{config['database']} > #{Rails.root}/db/#{Rails.application.class.parent_name}_#{rails_env}.sql`
      `pg_dump -U #{ENV["USER"]} #{config['database']} > #{Rails.root}/db/#{Rails.application.class.parent_name}_#{rails_env}.sql`
    elsif config.adapter == ("mysql" || "mysql2")
      #"next"
    end
  end

end
