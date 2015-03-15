module Bumbleworks
  module Api
    class EntitiesController < ApplicationController
      def types
        render :json => EntityClassPresenter.present(Bumbleworks.entity_classes)
      end

      def index
        render :json => EntityPresenter.present(entity_class.all)
      end

      def show
        entity = entity_class.first_by_identifier(params[:id])
        render :json => EntityPresenter.present(entity)
      end

    private

      def entity_class
        class_name = Bumbleworks::Support.camelize(params[:type])
        entity_class = Bumbleworks::Support.constantize(class_name)
      end
    end
  end
end