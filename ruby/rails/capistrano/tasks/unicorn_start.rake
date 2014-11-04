namespace :unicorn do
  task :start do
    on roles(:app) do
      if fetch(:app_type) == "rack"
        execute "cd '#{current_path}'; DEPLOY_ENV=#{fetch(:deploy_env)} ~/.rvm/bin/rvm default do bundle exec unicorn -c config/unicorn.rb -E production -D"
      else
        execute "cd '#{current_path}'; RAILS_ENV=#{fetch(:deploy_env)} ~/.rvm/bin/rvm default do bundle exec unicorn -c config/unicorn.rb -E production -D"
      end
    end
  end

end

