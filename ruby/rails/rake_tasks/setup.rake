namespace "setup" do
  desc "Setup directories"
  task :backbonejs, :environment do
    puts "Running the shit out of it: #{Rails.root}"
    `mkdir #{Rails.root}/app/assets/templates; touch #{Rails.root}/app/assets/templates/.gitkeep`
    `mkdir #{Rails.root}/app/assets/javascripts/models; touch #{Rails.root}/app/assets/javascripts/models/.gitkeep`
    `mkdir #{Rails.root}/app/assets/javascripts/collections; touch #{Rails.root}/app/assets/javascripts/collections/.gitkeep`
    `mkdir #{Rails.root}/app/assets/javascripts/views; touch #{Rails.root}/app/assets/javascripts/views/.gitkeep`
    `mkdir #{Rails.root}/app/assets/javascripts/routers; touch #{Rails.root}/app/assets/javascripts/routers/.gitkeep`
  end
end
