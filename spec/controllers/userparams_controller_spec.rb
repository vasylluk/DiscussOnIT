require 'rails_helper'

RSpec.describe UserparamsController, type: :controller do

let!(:user) { build(:user, email: "test@gmail.com") }

login_user

  it "should have a current_user" do
    expect(subject.current_user).to_not eq(nil)
  end

  describe "GET #show" do
    it "has a 200 status code" do
      expect(response.status).to eq(200)
    end
    it "responds to html by default" do
      expect(response.content_type)=="text/html"
    end
  end

  describe 'POST #destroy' do
    it "should not delete unavailable userparam" do
      expect(:delete => "/userparamsS/37").not_to be_routable
    end
  end


  describe 'POST #user_notif' do
    before do
  	before do
      @userparam = create(:userparam, user_id: subject.current_user.id)
      @notification = create(:notification, user_id:subject.current_user.id ,text: "params[:notification][:text]", resource_type: "User",resource_id: subject.current_user.id)
    end 
    it "should redirect back to the root path" do
      post :user_notif
      expect(response).to redirect_to root_path
    end
      post :notification
  		expect(response).to redirect_to root_path
  	end
  end
  
  describe 'GET #edit' do
    before do
      @userparam = create(:userparam, user_id: subject.current_user.id)
      @userparam.update(country: "USA")
    end  
    it "edit userparam" do
      get :edit, params: {id: subject.current_user.userparam.id}
      expect(subject.current_user.userparam.country).to eq("USA")
    end
  end
  
  describe 'PATCH #update' do
    before do
      @userparam = create(:userparam, user_id: subject.current_user.id)
    end  
    it "should update userparam" do 
      patch :update, params: { id: subject.current_user.id, userparam: {univ: "Test123"}}
      expect(subject.current_user.userparam.univ)=="Test123"
    end
    it "should redirect to profile" do
      patch :update, params: { id: subject.current_user.id, userparam: {univ: "Test123"}}
      expect(response).to redirect_to userparam_path(subject.current_user.id)
    end
  end
  
end
