require 'rails_helper'

RSpec.describe PostsController, type: :controller do

let!(:post) { build(:post) }

  describe "GET #new" do
    it "returns 302" do
      get :new
      expect(response).to have_http_status(302)
    end
  end

end
