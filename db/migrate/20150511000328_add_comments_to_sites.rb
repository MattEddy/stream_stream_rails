class AddCommentsToSites < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :usgs_site
      t.string  :content
      t.timestamps
    end
  end
end
