namespace :deploy do
  task :start do
    if File.exists? 'config/unicorn.rb'
      invoke 'unicorn:start'
    else
      puts 'will do something esle'
    end
  end
end
