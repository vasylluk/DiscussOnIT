require 'rails_helper'

RSpec.describe Post, type: :model do

let!(:user){create(:user)}
  subject{
    build(:post, user: user)
  }
		build(:post, user: user)
	}
  
    context "with 2 or more comments" do
      it "gets all postcomments of current post" do
        post = Post.create!(user_id: user.id, title: "title", body: "postbody")
        comment1 = post.postcomments.create!(user_id: user.id, :text => "first comment")
        comment2 = post.postcomments.create!(user_id: user.id, :text => "second comment")
        expect(post.postcomments).to eq([comment1, comment2])
      end
    end

    describe "validation" do
      it "is valid with valid attributes" do
        expect(subject).to be_valid
      end
      it "is not valid without body field" do
        subject.body = ""
        expect(subject).to_not be_valid
      end
      it "is not valid without title field" do
        subject.title = ""
        expect(subject).to_not be_valid
      end
  	describe "validation" do
  		it "is valid with valid attributes" do
    		expect(subject).to be_valid
  		end
	   	it "is not valid without body field" do
   			subject.body = ""
   			expect(subject).to_not be_valid
   		end
   		it "is not valid without title field" do
   			subject.title = ""
   			expect(subject).to_not be_valid
   		end
      it "is not valid with too short title" do
        subject.title = "lead"
        expect(subject).to_not be_valid
      end
      it "is not valid with too short body" do
        subject.body = "lead me"
        expect(subject).to_not be_valid
      end
  end
    context "association" do
     it { should belong_to(:user) }
  end

end
