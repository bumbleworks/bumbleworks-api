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
            new(presented, in_collection: true)
          }
        end
      end

      def initialize(presented, in_collection: false)
        @presented = presented
        @in_collection = in_collection
      end

      def in_collection?
        @in_collection == true
      end
    end
  end
end