namespace :deploy do

  desc 'Restart application'
  task :restart do
    if File.exists? 'config/unicorn.rb'
      invoke 'unicorn:restart'
    elsif File.exists? 'config/puma.rb'
      invoke 'puma:restart'
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
