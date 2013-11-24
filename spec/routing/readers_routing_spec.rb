require "spec_helper"

describe ReadersController do
  describe "routing" do

    it "routes to #index" do
      get("/readers").should route_to("readers#index")
    end

    it "routes to #new" do
      get("/readers/new").should route_to("readers#new")
    end

    it "routes to #show" do
      get("/readers/1").should route_to("readers#show", :id => "1")
    end

    it "routes to #edit" do
      get("/readers/1/edit").should route_to("readers#edit", :id => "1")
    end

    it "routes to #create" do
      post("/readers").should route_to("readers#create")
    end

    it "routes to #update" do
      put("/readers/1").should route_to("readers#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/readers/1").should route_to("readers#destroy", :id => "1")
    end

  end
end
