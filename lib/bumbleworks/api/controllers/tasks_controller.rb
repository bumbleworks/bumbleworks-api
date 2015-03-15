module Bumbleworks
  module Api
    class TasksController < ApplicationController
      def index
        render :json => Bumbleworks::Api::TaskPresenter.present(Bumbleworks::Task.all)
      end

      def show
        render :json => Bumbleworks::Api::TaskPresenter.present(task)
      end

      def claim
        task.claim(params[:claimant])
        render :json => Bumbleworks::Api::TaskPresenter.present(task)
      end

      def release
        task.release
        render :json => Bumbleworks::Api::TaskPresenter.present(task)
      end

      def complete
        task.complete(params_without_id)
        render :json => { :status => 'completed' }
      rescue Bumbleworks::Task::NotCompletable => e
        render :json => {
          :status => 'not_completable',
          :message => e.message
        }, :status => 422
      end

    private

      def task
        Bumbleworks::Task.find_by_id(params[:id])
      end

      def params_without_id
        params.reject { |k,v| k.to_s == "id" }
      end
    end
  end
end