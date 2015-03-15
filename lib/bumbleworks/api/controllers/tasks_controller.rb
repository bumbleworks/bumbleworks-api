module Bumbleworks
  module Api
    class TasksController < ApplicationController
      def index
        render :json => Bumbleworks::Api::TaskPresenter.present(Bumbleworks::Task.all)
      end

      def show
        render :json => Bumbleworks::Api::TaskPresenter.present(task)
      end

    private

      def task
        Bumbleworks::Task.find_by_id(params[:id])
      end
    end
  end
end