module Bumbleworks
  module Api
    class ExpressionsController < ApplicationController
      def show
        render :json => Bumbleworks::Api::ExpressionPresenter.present(expression)
      end

      def cancel
        expression.cancel!
        render :json => { "status" => "cancelled" }
      end

      def kill
        expression.kill!
        render :json => { "status" => "killed" }
      end

    private

      def expression
        process.expression_at_position(params[:id])
      end

      def process
        Bumbleworks::Process.new(params[:pid])
      end
    end
  end
end