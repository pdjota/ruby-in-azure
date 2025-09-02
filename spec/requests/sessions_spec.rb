require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /login" do
    it "returns http success" do
      get "/login"
      expect(response).to have_http_status(:success)
    end

    it "redirects to root if already logged in" do
      user = create(:user)
      post "/login", params: { email: user.email, password: 'password123' }
      get "/login"
      expect(response).to redirect_to(root_path)
    end
  end

  describe "POST /login" do
    let(:user) { create(:user, password: 'password123') }

    it "logs in with valid credentials" do
      post "/login", params: { email: user.email, password: 'password123' }
      expect(response).to redirect_to(root_path)
      expect(session[:user_id]).to eq(user.id)
    end

    it "does not log in with invalid email" do
      post "/login", params: { email: 'wrong@example.com', password: 'password123' }
      expect(response).to have_http_status(:unprocessable_content)
      expect(session[:user_id]).to be_nil
    end

    it "does not log in with invalid password" do
      post "/login", params: { email: user.email, password: 'wrongpassword' }
      expect(response).to have_http_status(:unprocessable_content)
      expect(session[:user_id]).to be_nil
    end
  end

  describe "DELETE /logout" do
    it "logs out the user" do
      user = create(:user)
      post "/login", params: { email: user.email, password: 'password123' }
      delete "/logout"
      expect(response).to redirect_to(root_path)
      expect(session[:user_id]).to be_nil
    end
  end
end
