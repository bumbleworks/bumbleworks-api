module Bumbleworks
  module Api
    class Application < Rory::Application
    end
  end
end

Bumbleworks::Api::Application.root = File.expand_path('..', File.dirname(__FILE__))
Bumbleworks::Api::Application.auto_require_paths << 'lib'
Bumbleworks::Api::Application.require_all_files
