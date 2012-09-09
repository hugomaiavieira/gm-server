require "spec_helper"

describe Api::V1::UsersController do
  it "routes to #create" do
    post("/api/v1/users").should route_to("api/v1/users#create")
  end

  it "routes to #sign_in" do
    post("/api/v1/users/sign_in").should route_to("api/v1/users#sign_in")
  end
end