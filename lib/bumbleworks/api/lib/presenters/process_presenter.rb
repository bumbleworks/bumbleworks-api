module Bumbleworks
  module Api
    class ProcessPresenter < Presenter
      def to_hash
        {
          :id => presented.id,
          :definition_name => presented.definition_name,
          :subscribed_events => presented.subscribed_events,
          :entity_name => presented.entity_name
        }.merge(extras)
      end

      def extras
        if in_collection?
          {}
        else
          {
            :original_tree => presented.original_tree
          }.merge(entity_hash)
        end
      end

      def entity_hash
        if presented.entity
          { :entity => EntityPresenter.present(presented.entity).to_hash }
        else
          {}
        end
      end
    end
  end
end