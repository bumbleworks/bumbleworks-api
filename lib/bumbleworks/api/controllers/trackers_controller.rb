module Bumbleworks
  module Api
    class TrackersController < ApplicationController
      def index
        render :json => Bumbleworks::Api::TrackerPresenter.present(Bumbleworks::Tracker.all)
      end

      def show
        render :json => Bumbleworks::Api::TrackerPresenter.present(Bumbleworks::Tracker.new(params[:id]))
      end
    end
  end
end