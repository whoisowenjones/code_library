# This file is not necessary with Cap v3. Keeping it around for informational purposes.
#namespace :deploy do
  #task :upload_settings do
    #on roles(:app) do
      #execute :mkdir, "-p #{shared_path}/config"
      #database_template = "config/database.yml.template"
      #upload! database_template, "#{shared_path}/config/database.yml" if File.exists? database_template
      #api_keys_template = "config/api_keys.yml.template"
      #upload! api_keys_template, "#{shared_path}/config/api_keys.yml" if File.exists? api_keys_template
    #end
  #end
#end
