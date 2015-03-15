module Bumbleworks
  module Api
    class Presenter
      attr_reader :presented

      class << self
        def present(presented)
          if presented.is_a?(Array)
            from_array(presented)
          else
            new(presented)
          end
        end

        def from_array(array)
          array.map { |presented|
            new(presented)
          }
        end
      end

      def initialize(presented)
        @presented = presented
      end

      def to_hash
        {
          :class => @entity_class.name,
          :count => @entity_class.count,
          :registered_processes => @entity_class.processes
        }
      end

      def registered_processes
        @entity_class.processes
      end
    end
  end
end