class UsgsSiteSerializer < ActiveModel::Serializer
  attributes :id, :site_id, :name, :state_code, :latitude, :longitude, :links

  has_many :comments
end
