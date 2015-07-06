require 'spec_helper'

describe UsgsSiteImporter do

  describe ".run" do
    before do

      UsgsSiteImporter.run("spec/fixtures/usgs_sites.xml")
    end

    it "creates two USGS sites" do
      UsgsSite.count.should == 2
    end

    describe "the first" do
      it "imports the site id" do
        expect(first_site.site_id).to eq "01010000"
      end

      it "imports the site's name" do
        expect(first_site.name).to eq "St. John River at Ninemile Bridge, Maine"
      end

      it "imports the site's state_code" do
        expect(first_site.state_code).to eq "23"
      end

      it "imports the site's latitude" do
        expect(first_site.latitude).to eq "46.70055556"
      end

      it "imports the site's longitude" do
        expect(first_site.longitude).to eq "-69.71555560"
      end
    end

    describe "the second" do
      it "imports the site id" do
        expect(last_site.site_id).to eq "01010070"
      end

      it "imports the site's name" do
        expect(last_site.name).to eq "Big Black River near Depot Mtn, Maine"
      end

      it "imports the site's state_code" do
        expect(last_site.state_code).to eq "23"
      end

      it "imports the site's latitude" do
        expect(last_site.latitude).to eq "46.89388889"
      end

      it "imports the site's longitude" do
        expect(last_site.longitude).to eq "-69.75166670"
      end
    end

    def first_site
      UsgsSite.first
    end

    def last_site
      UsgsSite.last
    end
  end
end
