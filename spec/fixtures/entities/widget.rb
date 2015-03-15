require_relative 'mock_entity'

class Widget < MockEntity
  include Bumbleworks::Entity

  process :task_process

  attr_accessor :task_process_identifier
end