require 'rails_helper'

RSpec.describe "Welcome", type: :request do
  describe "GET /" do
    context "when user is not logged in" do
      it "returns http success" do
        get root_path
        expect(response).to have_http_status(:success)
      end

      it "displays welcome message for anonymous users" do
        get root_path
        expect(response.body).to include("Welcome to Stock Management")
        expect(response.body).to include("Please log in to access the stock management system")
      end

      it "displays login link" do
        get root_path
        expect(response.body).to include("Login")
        expect(response.body).to include(login_path)
      end

      it "does not display user-specific content" do
        get root_path
        expect(response.body).not_to include("Welcome,")
        expect(response.body).not_to include("View Products")
        expect(response.body).not_to include("Manage Stores")
        expect(response.body).not_to include("Check Inventory")
      end
    end

    context "when user is logged in" do
      let(:user) { create(:user) }

      before do
        post login_path, params: { email: user.email, password: user.password }
        follow_redirect!
      end

      it "returns http success" do
        get root_path
        expect(response).to have_http_status(:success)
      end

      it "displays personalized welcome message" do
        get root_path
        expect(response.body).to include("Welcome, #{user.email}!")
        expect(response.body).to include("Manage your inventory, products, and stores with ease")
      end

      it "displays management action buttons" do
        get root_path
        expect(response.body).to include("View Products")
        expect(response.body).to include("Manage Stores")
        expect(response.body).to include("Check Inventory")
      end

      it "does not display login link" do
        get root_path
        expect(response.body).not_to include("Login")
        expect(response.body).not_to include(login_path)
      end
    end
  end
end
