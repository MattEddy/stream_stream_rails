module Api
  class MeasurementsController < ApplicationController
    after_filter :cors_set_access_control_headers

    def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin']      = '*'
      headers['Access-Control-Allow-Methods']     = 'POST, GET, OPTIONS'
      headers['Access-Control-Max-Age']           = '1728000'
      headers['Access-Control-Allow-Credentials'] = 'true'
    end

    def show
      render json: ::RiverMeasurementFetcher.days_ago(site.site_id, 31), each_serializer: MeasurementSerializer
    end

    def site
      UsgsSite.find(params[:id])
    end
  end
end
