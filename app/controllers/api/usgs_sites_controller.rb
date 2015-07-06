module Api
  class UsgsSitesController < ApplicationController
    respond_to :json

    def index
      render json: UsgsSite.name_matching(params[:search]).limit(100), each_serializer: UsgsSiteSerializer
    end

    def show
      site = UsgsSite.find(params[:id])
      render json: site, each_serializer: UsgsSiteSerializer
    end
  end
end
