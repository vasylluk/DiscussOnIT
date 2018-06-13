require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  context "with render_views" do
    render_views

    describe "GET index" do
      it "renders the actual template" do
        get :index
        expect(response.body).to eq(root_path.body)
      end
    end
  end

end
