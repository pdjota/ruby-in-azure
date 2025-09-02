require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /signup" do
    it "returns http success" do
      get "/signup"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /signup" do
    context "with valid attributes" do
      it "creates a new user and logs them in" do
        expect {
          post "/signup", params: { 
            user: { 
              email: 'test@example.com', 
              password: 'password123', 
              password_confirmation: 'password123' 
            } 
          }
        }.to change(User, :count).by(1)
        
        expect(response).to redirect_to(root_path)
        expect(session[:user_id]).to be_present
      end
    end

    context "with invalid attributes" do
      it "does not create a user with invalid email" do
        expect {
          post "/signup", params: { 
            user: { 
              email: 'invalid-email', 
              password: 'password123', 
              password_confirmation: 'password123' 
            } 
          }
        }.not_to change(User, :count)
        
        expect(response).to have_http_status(:unprocessable_content)
      end

      it "does not create a user with short password" do
        expect {
          post "/signup", params: { 
            user: { 
              email: 'test@example.com', 
              password: '12345', 
              password_confirmation: '12345' 
            } 
          }
        }.not_to change(User, :count)
        
        expect(response).to have_http_status(:unprocessable_content)
      end

      it "does not create a user with mismatched passwords" do
        expect {
          post "/signup", params: { 
            user: { 
              email: 'test@example.com', 
              password: 'password123', 
              password_confirmation: 'different123' 
            } 
          }
        }.not_to change(User, :count)
        
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end
end
