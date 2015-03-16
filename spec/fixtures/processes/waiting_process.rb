Bumbleworks.define_process do
  concurrence do
    wait_for_event :the_event, :where => :entities_match
    await :left_tag => 'local_event'
    await :error => /bad/
    await :participant => %w[goose bunnies]
  end
end
