require "rails_helper"

describe SessionsController do
  describe "#create" do
    it "logs in a user with a success message" do
      user = User.new(id: 1)
      allow(User).to receive(:from_omniauth).and_return user
      request.env["omniauth.auth"] = "auth"
      get :create, params: { provider: "google_oauth2" }
      expect(response).to redirect_to root_path
      expect(session[:user_id]).to eq user.id
      expect(User).to have_received(:from_omniauth).with "auth"
      expect(flash[:success]).to be_present
    end
  end

  describe "#failure" do
    it "redirects to home with a failure message" do
      get :failure
      expect(response).to redirect_to root_path
      expect(flash[:error]).to be_present
    end
  end

  describe "#destroy" do
    it "logs out the user with a message" do
      session[:user_id] = 1
      delete :destroy
      expect(response).to redirect_to root_path
      expect(session[:user_id]).to be_nil
      expect(flash[:success]).to be_present
    end
  end
end
