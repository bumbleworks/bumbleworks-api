Bumbleworks.define_process do
  concurrence do
    admin :task => 'do_something'
    peon :task => 'do_something_dumb'
  end
  fall_apart
  peon :task => 'meekly_do_another_thing'
  admin :task => 'confront'
end