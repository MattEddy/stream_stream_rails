namespace :import do
  desc "Import USGS sites from text files"
  task :sites => :environment do
    puts "Importing sites\n"
    UsgsSiteImporter.run("data/sites.xml")
  end
end
