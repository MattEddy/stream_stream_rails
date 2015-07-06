class UsgsSiteImporter
  require "csv"

  def self.run(filepath)
    self.new(filepath).run
  end

  def initialize(filepath)
    @filepath = filepath
  end

  def file
    Rails.root.join(@filepath).read
  end

  def run
    Hash.from_xml(file)["usgs_nwis"]["site"].each do |site|
      UsgsSite.create!({
        site_id:     site["site_no"],
        name:        site["station_nm"],
        latitude:    site["dec_lat_va"],
        longitude:   site["dec_long_va"],
        state_code:  site["state_cd"].to_i
      })
    end
  end
end
