require_relative 'entities/widget'
require_relative 'entities/widgety_fidget'

Bumbleworks.configure do |c|
  c.storage = {}
  c.root = File.dirname(__FILE__)
end

Bumbleworks.bootstrap!
Bumbleworks.initialize!