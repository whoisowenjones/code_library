namespace "setup" do
  desc "Setup default BackboneJS directories (for new projects)"
  namespace :backbone do

    templates = "#{Rails.root}/app/assets/templates"
    directory "#{templates}"

    models = "#{Rails.root}/app/assets/javascripts/models"
    directory "#{models}"

    collections = "#{Rails.root}/app/assets/javascripts/collections"
    directory "#{collections}"

    views = "#{Rails.root}/app/assets/javascripts/views"
    directory "#{views}"

    routers = "#{Rails.root}/app/assets/javascripts/routers"
    directory "#{routers}"

    task :dirs => [templates, models, collections, views, routers] do
      `touch #{templates}/.gitkeep`
      `touch #{models}/.gitkeep`
      `touch #{collections}/.gitkeep`
      `touch #{views}/.gitkeep`
      `touch #{routers}/.gitkeep`
    end
  end


  task :db_file => ['config/database.yml'] do
  end

  #desc "Set up Rails app for new user"
  task :project => ['setup:db_file', 'db:restore'] do
  end

  namespace :db_file do
    file "config/database.yml" => ['config/database.yml.template'] do
      cp "config/database.yml.template", "config/database.yml"
    end
  end

  #desc "Set up test directories if not present"
  namespace :spec do
    controllers = "#{Rails.root}/spec/controllers"
    directory "#{controllers}"

    features = "#{Rails.root}/spec/features"
    directory "#{features}"

    helpers = "#{Rails.root}/spec/helpers"
    directory "#{helpers}"

    requests = "#{Rails.root}/spec/requests"
    directory "#{requests}"

    routing = "#{Rails.root}/spec/routing"
    directory "#{routing}"

    views = "#{Rails.root}/spec/views"
    directory "#{views}"

    task :dirs => [controllers, features, helpers, requests, routing, views] do
      `touch #{controllers}/.gitkeep`
      `touch #{features}/.gitkeep`
      `touch #{helpers}/.gitkeep`
      `touch #{requests}/.gitkeep`
      `touch #{routing}/.gitkeep`
      `touch #{views}/.gitkeep`
    end
  end
  
  #desc "Add config/app_config file"
  task :config do

    require 'yaml'

    config_file = "#{Rails.root}/config/app_config.yml"
    `touch #{config_file}`

    puts "\nApplication Name?"
    name = $stdin.gets.chomp

    yaml_file = YAML.load(File.open("#{config_file}"))

    if yaml_file
      yaml_file['name'] = name
      yaml = yaml_file.to_yaml
    else
      yaml = { :name => "#{name}"}.to_yaml
    end

    File.open("#{config_file}", "w") {|f| f.write(yaml) }

  end
  
  
end
