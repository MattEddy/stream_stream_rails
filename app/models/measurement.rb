class Measurement
  include ActiveModel::Model
  include ActiveModel::Serialization

  attr_reader :site_id, :time, :measurements, :id

  def initialize(id, site_id, time, measurements)
    @id = id
    @measurements = measurements
    @time = time
    @site_id = site_id.to_s
  end

  # These two methods flow_rate and stream height
  # translate the usgs parlance to flow_rate and
  # stream height
  def flow_rate
    measurements["Streamflow, ft&#179;/s"]
  end

  def stream_height
    measurements["Gage height, ft"]
  end

  def ==(other)
    measurements == other.measurements && site_id == other.site_id && time == other.time
  end

  def to_s
    "Time: " + time.to_s + " Stream Height: " + self.stream_height.to_s + " Flow Rate: " + self.flow_rate.to_s
  end
end
