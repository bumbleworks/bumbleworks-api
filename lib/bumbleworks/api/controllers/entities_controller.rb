module Bumbleworks
  module Api
    class EntitiesController < ApplicationController
      def types
        render :json => EntityClassPresenter.from_array(Bumbleworks.entity_classes)
      end

      def index
        render :json => EntityPresenter.from_array(entity_class.all)
      end

      def show
        render :json => EntityPresenter.new(entity_class.first_by_identifier(params[:id]))
      end

    private

      def entity_class
        class_name = Bumbleworks::Support.camelize(params[:type])
        entity_class = Bumbleworks::Support.constantize(class_name)
      end
    end
  end
end