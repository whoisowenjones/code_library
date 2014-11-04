namespace :shell do

  task :query_env do
    on roles(:app) do
      info capture("env")
    end
  end

  task :query_home do
    on roles(:app) do
      info capture("echo ~")
    end
  end

  task :query_interactive do
    on roles(:app) do
      info capture("[[ $- == *i* ]] && echo 'Interactive' || echo 'Not interactive'")
    end
  end

  task :query_login do
    on roles(:app) do
      if execute "ps -p $$ | awk '{print $4}' | sed 1d" =~ /zsh/
        info capture("[[ -o login ]] && echo 'Login shell' || echo 'Not login shell'")
      else
        info capture("shopt -q login_shell && echo 'Login shell' || echo 'Not login shell'")
      end
    end
  end

end
