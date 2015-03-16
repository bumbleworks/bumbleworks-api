require_relative 'spec/fixtures/bumbleworks_config'
require_relative 'spec/support/process_helpers'
include ProcessHelpers

Bumbleworks.start_worker!

Widget.truncate!
WidgetyFidget.truncate!

widget_processes = 20.times.collect do |i|
  Widget.new(i).launch_process('task_process')
end

5.times do |i|
  WidgetyFidget.new(i)
end

wp = Bumbleworks.launch!('waiting_process')

ProcessHelpers.wait_until(:timeout => 30) do
  wp.reload.trackers.count == 4
end

widget_processes.first(3).each do |p|
  p.tasks.map(&:complete)
end
