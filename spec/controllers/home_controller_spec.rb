require "rails_helper"

describe HomeController do
  it "has a show route" do
    get :show
    expect(response).to be_ok
  end
end
