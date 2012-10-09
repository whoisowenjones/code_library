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

  namespace :db_file do
    file "config/database.yml" => ['config/database.yml.template'] do
      cp "config/database.yml.template", "config/database.yml"
    end
  end

  #desc "Set up Rails app for new user"
  task :project => ['setup:db_file', 'db:restore'] do
  end
end
