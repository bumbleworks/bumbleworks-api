module Bumbleworks
  module Api
    class EntityClassPresenter < Presenter
      def to_hash
        {
          :class => presented.name,
          :count => presented.count,
          :registered_processes => registered_processes
        }
      end

      def registered_processes
        presented.processes.map { |name, attributes|
          attributes.merge(:name => name)
        }
      end
    end
  end
end