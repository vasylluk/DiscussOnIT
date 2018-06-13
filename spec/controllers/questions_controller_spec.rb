require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  context "without render_views" do
    describe "GET index" do
      it "renders the RSpec generated template" do
        get :index
        expect(response.body).to eq("")
      end
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

end
