class MeasurementSerializer < ActiveModel::Serializer
  attributes :time, :site_id, :flow_rate, :stream_height, :id
end
