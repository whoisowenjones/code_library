task :confirm, :msg do |t, msg|
  set :confirmed, proc {

    puts <<-WARN

    ========================================================================

      WARNING: You are about to do something potentially dangerous.

      Please confirm that you really want to do that.

    ========================================================================

    WARN
    ask :answer, "Type 'yes' to continue."
    fetch(:answer) == 'yes' ? true : false

  }.call

  unless fetch(:confirmed)
    puts "\nCancelled!"
    exit
  end

end
