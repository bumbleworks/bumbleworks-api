require "rory"
require "rack"
require "bumbleworks"
require "json"
require_relative "api/version"
require_relative "api/controllers/application_controller"

Rufus::Json.detect_backend

module Bumbleworks
  module Api
  end
end

require_relative "api/config/application"
