module Bumbleworks
  module Api
    class ProcessesController < ApplicationController
      def index
        processes = Bumbleworks::Process.all(:limit => limit, :offset => offset)
        render :json => Bumbleworks::Api::ProcessPresenter.present(processes)
      end

      def show
        process = Bumbleworks::Process.new(params[:id])
        render :json => Bumbleworks::Api::ProcessPresenter.present(process)
      end

    private

      def page
        params.fetch(:page) { 1 }.to_i
      end

      def limit
        params.fetch(:limit) { 10 }.to_i
      end

      def offset
        (page - 1) * limit
      end
    end
  end
end