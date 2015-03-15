module Bumbleworks
  module Api
    class TaskPresenter < Presenter
      def to_hash
        {
          :id => presented.id,
          :name => presented.to_s,
          :role => presented.role,
          :claimant => presented.claimant,
          :process_id => presented.wfid
        }
      end
    end
  end
end