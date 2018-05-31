require 'rails_helper'

RSpec.describe AnscommentsController, type: :controller do

let!(:user) { build(:user) }

login_user

let!(:anscomment) { build(:anscomment) }

  it "should have a current_user" do
    expect(subject.current_user).to_not eq(nil)
  end


  # describe "GET #show" do
  #   it "assigns the requested anscomment to @anscomment" do
  #     anscomment = FactoryBot(:anscomment)
  #     get :show, id: anscomment
  #     assigns(:anscomment).should eq(anscomment)
  #   end
  #   it "renders the login page" do
  #     expect(response).to render_template('anscomments/show')
  #   end
  # end

  # describe 'POST #create' do
  #   it "should create anscomment" do
  #     post :create, params: {anscomment: {text: "TESTANSCOMM"},user_id:current_user.id}
  #     expect(subject.anscomment.text).to eq("TESTANSCOMM")
  #     expect(response).to redirect_to question_path(anscomment.answer.question.id)
  #   end
  # end

  # it "should belongs to an answer" do
  #   expect(:anscomment.answer_id).to_not eq(nil)
  # end

  describe "GET #show" do
    it "has a 200 status code" do
      expect(response.status).to eq(200)
    end
    it "responds to html by default" do
      expect(response.content_type)=="text/html"
    end
  end
  
  describe "GET #create" do
    it "renders the 'new' template" do
      expect(response).to render_template("new")
    end
  end
  
  describe 'POST #destroy' do
  	it "should not delete " do
  		expect(:delete => "/anscomments/1234").not_to be_routable
  	end
  end

  describe 'PATCH #update' do
  	before do
      @anscomment = create(:anscomment, user_id: subject.current_user.id)
    end  
    it "should update anscomment" do
      patch :update, params: { id: subject.current_user.id, anscomment: {text: "Test123"}}
      expect(@anscomment.text)=="Test123"
    end
    it "should redirect to profile" do
   	  patch :update, params: { id: subject.current_user.id, anscomment: {text: "Test123"}}
      expect(response).to redirect_to userparam_path(subject.current_user.id)
    end
  end
  
end
