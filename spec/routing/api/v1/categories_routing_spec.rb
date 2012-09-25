require "spec_helper"

describe Api::V1::CategoriesController do
  it "routes to #create" do
    post("/api/v1/categories/sync").should route_to("api/v1/categories#sync")
  end
end