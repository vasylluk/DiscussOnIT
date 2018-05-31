require 'rails_helper'

RSpec.describe VotesController, type: :controller do
let!(:user) { build(:user) }

login_user

let!(:vote) { build(:vote) }

  describe 'POST #destroy' do
    it "should not delete anyway" do
      expect(:delete => "/vote/21").not_to be_routable
    end
  end

  it "should have a current_user" do
    expect(subject.current_user).to_not eq(nil)
  end


end
