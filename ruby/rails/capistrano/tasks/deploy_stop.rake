namespace :deploy do
  task :stop do
    if File.exists? 'config/unicorn.rb'
      invoke 'unicorn:stop'
    elsif File.exists? 'config/puma.rb'
      invoke 'puma:stop'
    end
  end
end
