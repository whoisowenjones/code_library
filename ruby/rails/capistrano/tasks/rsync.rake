namespace :rsync do

  namespace :assets do
    task :up do
      if invoke(:confirm)
        if fetch(:deploy_env) == "staging"
          sh "rsync -zavr --exclude .dropbox --exclude Icon? --delete public/system/ powderbird:/var/www/#{fetch(:application)}/shared/public/system"
        end
      end
    end

    task :down do
      if fetch(:deploy_env) == "staging"
        sh "rsync -zavr --delete powderbird:/var/www/#{fetch(:application)}/shared/public/system/ public/system"
      end
    end
  end

  #namespace :data do
    #task :invoke, [:command] => 'rake db:export_all' do |task, args|
      #on primary(:app) do
        #within current_path do
          #with :rails_env => fetch(:rails_env) do
            #rake args[:command]
          #end
        #end
      #end
    #end

    #task :down do
      #puts "will go down"
    #end
  #end

end
