module Bumbleworks
  module Api
    class ErrorPresenter < Presenter
      def to_hash
        {
          :process_id => presented.wfid,
          :expression_id => presented.expression.expid,
          :error_class_name => presented.error_class_name,
          :message => presented.message,
          :backtrace => presented.backtrace
        }
      end
    end
  end
end