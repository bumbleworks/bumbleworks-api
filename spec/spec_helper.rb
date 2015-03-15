require 'simplecov'
SimpleCov.start

require 'capybara/rspec'
require 'bumbleworks/api'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

require_relative 'fixtures/bumbleworks_config.rb'

RSpec.configure do |config|
  config.include ApiHelper
  config.include ProcessHelpers

  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  config.before(:suite, :type => :features) do
    Bumbleworks.start_worker!
  end

  config.before(:each) do
    Bumbleworks.kill_all_processes!
    Widget.truncate!
    WidgetyFidget.truncate!
  end

  config.after(:suite, :type => :features) do
    Bumbleworks::Worker.shutdown_all
  end
end
