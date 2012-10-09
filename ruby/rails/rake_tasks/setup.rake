namespace "setup" do
  desc "Setup directories"
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
end
