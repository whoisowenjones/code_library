namespace :deploy do

  task :rsync do
    if fetch(:deploy_env) == "staging"
      sh "rsync -zavr --exclude .dropbox --exclude Icon? --delete public/system/ powderbird:/var/www/#{fetch(:application)}/shared/public/system"
    end

  end

end
