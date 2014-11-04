namespace :unicorn do
  task :restart do
    on roles(:all), in: :sequence, wait: 5 do
      pid_exists = capture("if [ -f #{deploy_to}/current/tmp/pids/#{fetch(:deploy_env)}.pid ]; then echo 'true'; fi")
      if pid_exists == 'true'
        execute "kill -s USR2 `cat #{deploy_to}/current/tmp/pids/#{fetch(:deploy_env)}.pid`"
        execute "old_pid=`ps aux | grep 'unicorn master (old)' | grep -v grep | awk '{print $2}'`; if [ $old_pid ]; then kill -9 $old_pid; fi"
      end
    end
  end
end
