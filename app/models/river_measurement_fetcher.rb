class RiverMeasurementFetcher
  attr_reader :site_id

  def self.days_ago(site_id, days)
    self.new(site_id).days_ago(days)
  end

  def initialize(site_id)
    @site_id = site_id
  end

  def days_ago(days)
    parse UsgsRequest.new(period: "P#{days}D", parameterCd: "00060,00065", sites: site_id).response
  end

  private

  def parse(response)
    time_series = response["value"]["timeSeries"].map do |time_series_raw|
      Series.new(time_series_raw)
    end
    create_river_measurements(time_series)
  end

  def create_river_measurements(series)
    id = 0
    data_points = all_data_points(series).map do |time, data_points|
      id += 1
      Measurement.new(id, site_id, time, Hash[data_points.map { |dp| [dp.variable_name, dp.value] }])
    end
  end

  def all_data_points(series)
    series.flat_map(&:data_points).group_by(&:time)
  end

  class Series
    attr_reader :raw, :data_points

    def initialize(raw)
      @raw = raw
    end

    def site_name
      raw["sourceInfo"]["siteName"]
    end

    def data_points
      raw["values"].first["value"].map do |data_point|
        DataPoint.new(data_point, self.variable_name)
      end
    end

    def variable_name
      raw["variable"]["variableName"]
    end
  end

  class DataPoint
    attr_reader :raw, :variable_name

    def initialize(raw, variable_name)
      @raw = raw
      @variable_name = variable_name
    end

    def time
      Time.parse raw["dateTime"]
    end

    def value
      raw["value"].to_f
    end
  end

end
