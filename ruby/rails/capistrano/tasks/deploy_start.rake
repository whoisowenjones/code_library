namespace :deploy do
  task :start do
    if File.exists? 'config/unicorn.rb'
      invoke 'unicorn:start'
    elsif File.exists? 'config/puma.rb'
      invoke 'puma:start'
    end
  end
end
