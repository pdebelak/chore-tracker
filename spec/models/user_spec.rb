require "rails_helper"

describe User do
  class FakeAuth
    def initialize(email:, name:, image:)
      @email = email
      @name = name
      @image = image
    end

    def info
      OpenStruct.new(
        email: @email,
        name: @name,
        image: @image,
      )
    end
  end

  describe ".from_omniauth" do
    let(:auth) do
      FakeAuth.new(
        email: "peter@email.com",
        name: "Peter",
        image: "the_image.com"
      )
    end

    context "when a user does not exist" do
      it "creates the user" do
        user = User.from_omniauth(auth)
        expect(User.first).to eq user
        expect(user.email).to eq "peter@email.com"
        expect(user.name).to eq "Peter"
        expect(user.image_url).to eq "the_image.com"
      end
    end

    context "when the user exists" do
      let!(:existing_user) { create :user, email: "peter@email.com" }

      it "updates the user" do
        user = User.from_omniauth(auth)
        expect(user.id).to eq existing_user.id
        expect(user.email).to eq "peter@email.com"
        expect(user.name).to eq "Peter"
        expect(user.image_url).to eq "the_image.com"
      end
    end
  end
end
