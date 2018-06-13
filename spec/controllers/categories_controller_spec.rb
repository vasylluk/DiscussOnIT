require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

let!(:category) { build(:category) }
  
  context "with render_views" do
    render_views

    describe "GET index" do
      it "renders the actual template" do
        get :index
        expect(response.body).to match Category.all
      end
    end
  end

  it "shouldn't have a current_user" do
    expect(subject.current_user).to eq(nil)
  end

  describe "GET #show" do
    it "has a 200 status code" do
      expect(response.status).to eq(200)
    end
    it "responds to html by default" do
      expect(response.content_type)=="text/html"
    end
  end


end
