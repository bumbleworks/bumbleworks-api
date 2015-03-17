module Bumbleworks
  module Api
    class WorkersController < ApplicationController
      AllowedCommands = ["pause", "unpause", "shutdown"]

      before_action :refresh_worker_info, :only => [:index, :show]

      def index
        worker_info = Bumbleworks::Worker::Info.all
        render :json => Bumbleworks::Api::WorkerPresenter.present(worker_info)
      end

      def show
        worker_info = Bumbleworks::Worker::Info[params[:id]]
        render :json => Bumbleworks::Api::WorkerPresenter.present(worker_info)
      end

      def change_state
        command = params[:command]
        if AllowedCommands.include?(command.to_s)
          worker_info = Bumbleworks::Worker::Info[params[:id]]
          worker_info.send(command)
          render :json => { "status" => "#{command} sent" }
        else
          render :json => { "error" => "not_found" }, :status => 404
        end
      end

      def change_global_state
        command = params[:command]
        if AllowedCommands.include?(command.to_s)
          Bumbleworks::Worker.send("#{command}_all")
          render :json => { "status" => "#{command} sent" }
        else
          render :json => { "error" => "not_found" }, :status => 404
        end
      end

      def prune_stale_worker_info
        Bumbleworks::Worker::Info.purge_stale_worker_info
        render :json => { "status" => "pruned_stale_worker_info" }
      end

    private

      def refresh_worker_info
        Bumbleworks::Worker.refresh_worker_info
      end
    end
  end
end