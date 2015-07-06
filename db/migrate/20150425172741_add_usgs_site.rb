class AddUsgsSite < ActiveRecord::Migration
  def change
    create_table :usgs_sites do |t|
      t.string  :site_id
      t.string  :name
      t.string  :state_code
      t.string  :county_code
      t.string  :latitude
      t.string  :longitude
      t.boolean :active
      t.timestamps
    end
  end
end
