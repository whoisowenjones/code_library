namespace :deploy do
  task :stop do
    if File.exists? 'config/unicorn.rb'
      invoke 'unicorn:stop'
    else
      puts 'will do something else'
    end
  end
end
