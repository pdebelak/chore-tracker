require "rails_helper"

describe HomeController do
  it "has a show route" do
    get :show
    expect(response).to be_ok
  end

  context "when a user is signed in" do
    let(:user) { create :user }

    it "redirects to the lists path" do
      session[:user_id] = user.id
      get :show
      expect(response).to redirect_to lists_path
    end
  end
end
