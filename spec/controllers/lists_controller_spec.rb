require "rails_helper"

describe ListsController do
  describe "#index" do
    let(:user) { create :user }
    let!(:users_list) { create :list, users: [user] }
    let!(:other_list) { create :list }

    it "shows the user's lists" do
      session[:user_id] = user.id
      get :index
      expect(assigns :lists).to eq [users_list]
    end
  end

  describe "#show" do
    let(:user) { create :user }

    before { session[:user_id] = user.id }

    context "when list belongs to user" do
      let(:list) { create :list, users: [user] }

      it "shows the list" do
        get :show, params: { id: list.id }
        expect(assigns :list).to eq list
      end
    end

    context "list does not belong to user" do
      let(:list) { create :list }

      it "404s" do
        expect { get :show, params: { id: list.id } }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "#create" do
    def create_list
      post :create, params: { list: { name: "List name" } }
    end

    context "with no current user" do
      it "redirects to root path" do
        create_list
        expect(response).to redirect_to root_path
        expect(List.all).to be_empty
      end
    end

    context "with a current user" do
      it "creates a list and redirects to lists path" do
        user = create :user
        session[:user_id] = user.id
        create_list
        list = List.first
        expect(response).to redirect_to list_path(list)
        expect(list.name).to eq "List name"
        expect(list.users).to include user
        expect(user.lists).to include list
      end

      context "without required params" do
        it "re-renders the new page" do
          user = create :user
          session[:user_id] = user.id
          post :create, params: { list: { name: "" } }
          expect(response).to be_ok
          expect(List.all).to be_empty
        end
      end
    end
  end

  describe "#update" do
    let(:user) { create :user }

    def update_list
      put :update, params: { id: list.id, list: { name: "New name" } }
    end

    before { session[:user_id] = user.id }

    context "when list belongs to user" do
      let(:list) { create :list, users: [user] }

      it "updates the list" do
        update_list
        expect(response).to redirect_to list_path(list)
        expect(list.reload.name).to eq "New name"
        expect(flash[:success]).to be_present
      end

      context "but the list could not be updated" do
        it "rerenders the form and does not update the list" do
          expect { put :update, params: { id: list.id, list: { name: "" } } }.not_to change { list.reload.name }
          expect(response).to be_ok
        end
      end
    end

    context "list does not belong to user" do
      let(:list) { create :list }

      it "404s" do
        expect { update_list }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "#destroy" do
    let(:user) { create :user }
    let(:list) { create :list, users: [user] }
    before { session[:user_id] = user.id }

    it "destroys the list" do
      delete :destroy, params: { id: list.id }
      expect(response).to redirect_to lists_path
      expect { List.find(list.id) }.to raise_error ActiveRecord::RecordNotFound
      expect(flash[:success]).to be_present
    end
  end

  describe "#add_user" do
    let(:user) { create :user }
    let(:list) { create:list, users: [user] }
    before { session[:user_id] = user.id }

    it "adds the user" do
      other_user = create :user
      patch :add_user, params: { id: list.id, list: { user_email: other_user.email } }
      expect(response).to redirect_to list_path(list)
      expect(list.reload.users).to match_array [user, other_user]
      expect(flash[:success]).to be_present
    end

    context "when the user is not found" do
      it "shows an error" do
        patch :add_user, params: { id: list.id, list: { user_email: "madeup@email.com" } }
        expect(response).to be_ok
        expect(list.reload.users).to eq [user]
        expect(flash[:error]).to be_present
      end
    end
  end
end
