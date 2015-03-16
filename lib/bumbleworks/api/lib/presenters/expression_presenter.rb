module Bumbleworks
  module Api
    class ExpressionPresenter < Presenter
      def to_hash
        hash = {
          :process_id => presented.process.id,
          :expression_id => presented.expid,
          :tree => presented.tree
        }
        if presented.error
          hash.merge!(:error => ErrorPresenter.present(presented.error).to_hash)
        end
        hash
      end
    end
  end
end