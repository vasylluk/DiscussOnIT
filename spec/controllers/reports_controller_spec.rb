require 'rails_helper'

RSpec.describe ReportsController, type: :controller do

    describe "GET index" do
      it "renders the actual template" do
        get :index
        expect(response.body).to eq("")
      end
    end
end
