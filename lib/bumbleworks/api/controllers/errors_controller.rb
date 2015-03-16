module Bumbleworks
  module Api
    class ErrorsController < ApplicationController
      def index
        render :json => Bumbleworks::Api::ErrorPresenter.present(Bumbleworks.errors)
      end

      def show
        render :json => Bumbleworks::Api::ErrorPresenter.present(error)
      end

      def replay
        error.replay
        render :json => { :status => 'replayed' }
      end

    private

      def expression
        process.expression_at_position(params[:id])
      end

      def error
        expression.error
      end

      def process
        Bumbleworks::Process.new(params[:pid])
      end
    end
  end
end