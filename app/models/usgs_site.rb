class UsgsSite < ActiveRecord::Base
  has_many :comments

  def self.name_matching(name)
    where(UsgsSite.arel_table[:name].matches("%#{name}%"))
  end

  def links
    JSON.parse({ measurements: Rails.application.routes.url_helpers.api_measurement_url(id) }.to_json)
  end
end
