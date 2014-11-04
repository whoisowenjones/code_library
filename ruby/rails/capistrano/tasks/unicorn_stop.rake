namespace :unicorn do
  task :stop do
    on roles(:app) do
      execute "cat #{deploy_to}/current/tmp/pids/#{fetch(:deploy_env)}.pid | xargs kill -QUIT"
      execute "if [ -e #{deploy_to}/tmp/sockets/#{fetch(:deploy_env)}.sock ]; then rm #{deploy_to}/tmp/sockets/#{fetch(:deploy_env)}.sock; fi"
      execute "if [ -e #{deploy_to}/tmp/pids/#{fetch(:deploy_env)}.pid ]; then rm #{deploy_to}/tmp/pids/#{fetch(:deploy_env)}.pid; fi"
    end
  end
end

