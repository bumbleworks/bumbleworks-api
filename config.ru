ENV['RORY_ENV'] ||= ENV['RACK_ENV'] || 'development'

require 'bumbleworks/api'
require_relative 'playground_setup'

if ENV['MOUNT_AT']
  app = Rack::Builder.new do
    map ENV['MOUNT_AT'] do
      run Bumbleworks::Api::Application
    end
  end
  run app
else
  run Bumbleworks::Api::Application
end

