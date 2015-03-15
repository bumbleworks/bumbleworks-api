module Bumbleworks
  module Api
    class EntityPresenter < Presenter
      def to_hash
        {
          :identifier => presented.identifier,
          :name => presented.to_s,
          :process_count => presented.processes.count
        }
      end
    end
  end
end