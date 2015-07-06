class UsgsRequest < Struct.new(:options)
  require 'uri'
  require 'net/http'
  require 'json'

  HOST = "http://waterservices.usgs.gov/nwis/iv/"

  def response
    JSON.parse Net::HTTP.get(uri)
  end

  private

  def uri
    URI(HOST).tap { |uri| uri.query = query_params }
  end

  def query_params
    {format: :json}.merge(options).to_query
  end
end
