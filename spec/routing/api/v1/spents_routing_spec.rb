require "spec_helper"

describe Api::V1::SpentsController do
  it "routes to #create" do
    post("/api/v1/spents/sync").should route_to("api/v1/spents#sync")
  end
end