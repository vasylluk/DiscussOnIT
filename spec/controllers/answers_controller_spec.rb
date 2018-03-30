require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #positiv_vote" do
    it "returns http success" do
      get :positiv_vote
      expect(response).to have_http_status(:success)
    end
  end

end
