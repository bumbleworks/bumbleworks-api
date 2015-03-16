module Bumbleworks
  module Api
    class TrackerPresenter < Presenter
      def to_hash
        {
          :id => presented.id,
          :waiting_expression => presented.waiting_expression,
          :original_hash => presented.original_hash,
          :action => presented.action,
          :conditions => presented.conditions,
          :process_id => presented.wfid
        }
      end
    end
  end
end