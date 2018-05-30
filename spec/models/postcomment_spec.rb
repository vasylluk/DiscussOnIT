require 'rails_helper'

RSpec.describe Postcomment, type: :model do

let!(:user){create(:user)}
let!(:post){create(:post)}
  subject{
		build(:postcomment, user: user, post: post)
	}
  	describe "validation" do
  		it "is valid with valid attributes" do
    		expect(subject).to be_valid
  		end
	   	it "is not valid without text field" do
   			subject.text = ""
   			expect(subject).to_not be_valid
   		end
   		it "is not valid without user_id" do
   			subject.user_id = nil
   			expect(subject).to_not be_valid
   		end
   		it "is not valid without post_id" do
   			subject.post_id = nil
   			expect(subject).to_not be_valid
   		end
   		it "is not valid with too short text" do
   			subject.text = "lol"
   			expect(subject).to_not be_valid
   		end
	end
	context "association" do
     it { should belong_to(:user) }
     it { should belong_to(:post)}
  end

end
