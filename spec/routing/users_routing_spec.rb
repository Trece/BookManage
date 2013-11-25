require "spec_helper"

describe UsersController do
  describe "routing" do

    it "routes to #index" do
      get("/users").should route_to("users#index")
    end

    it "routes to #logout" do
      get("/users/2/logout").should route_to("users#logout", id: "2")
    end

  end
end
