require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
let!(:user) { build(:user) }

login_user

let!(:answer) { build(:answer) }

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
    it "should not delete unavailable answer" do
      expect(:delete => "/answers/2321").not_to be_routable
    end
  end

  describe 'POST #create' do
    before do
      @question = create(:question)
      @answer = create(:answer, user_id: subject.current_user.id, question_id: @question.id, text: "TESTSERS")
    end
    it "should be true" do
      # post :create, params: {answer: {text: "EWWSWESW"}}
      expect(@answer.text).to eq("TESTSERS")
    end
  end
  
  describe 'PATCH #update' do
    # before do
    #   @question = create(:question)
    #   @answer = create(:answer, user_id: subject.current_user.id, question_id: @question.id, text: "TESTSERS")
    # end  
    it "should update answer" do 
      patch :update, params: { user_id: subject.current_user.id, answer: {text: "Test123321"}}
      expect(@answer.text)=="Test123321"
    end
  end

end
