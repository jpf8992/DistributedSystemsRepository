 #Demonstration
# -------------
# Running this file will display how the thread pool works.
if $0 == __FILE__
  # - First, we create a new thread pool with a size of 10. This number is
  #   lower than our planned amount of work, to show that threads do not
  #   exit once they have finished a task.
  p = Pool.new(3)
  
  # - Next we simulate some workload by scheduling a large amount of work
  #   to be done. The actual time taken for each job is randomized. This
  #   is to demonstrate that even if two tasks are scheduled approximately
  #   at the same time, the one that takes less time to execute is likely
  #   to finish before the other one.
  20.times do |i|
    p.schedule do
      sleep rand(4) + 2
     puts "Job #{i} finished by thread #{Thread.current[:id]}"
    end
  end

  # - Finally, register an `at_exit`-hook that will wait for our thread pool
  #   to properly shut down before allowing our script to completely exit.
  at_exit { p.shutdown }
end