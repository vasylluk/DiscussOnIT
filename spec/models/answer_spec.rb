require 'rails_helper'

RSpec.describe Answer, type: :model do
<<<<<<< HEAD
=======

let!(:user){create(:user)}
let!(:question){create(:question)}

>>>>>>> c1b856ff81708e65655cd37032717dcc1d093d7c
  subject{
		build(:answer, user: user, question: question)
	}
<<<<<<< HEAD
  	describe "validation" do
   		it "is valid with valid attributes" do
   			expect(subject).to be_valid
   		end
	end
	describe "associations" do
		it{ should have_one(:user_id).dependent(:destroy)}
	end

	describe "associations" do
		it{ should have_one(:question_id).dependent(:destroy)}
	end
=======
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
      it "is not valid without question_id" do
        subject.question_id = nil
        expect(subject).to_not be_valid
      end
      it "is not valid with too short text" do
        subject.text = "lol"
        expect(subject).to_not be_valid
      end
  end
	context "association" do
     it { should belong_to(:user) }
     it { should belong_to(:question) }
     it { should have_many(:anscomments) }
  end

>>>>>>> c1b856ff81708e65655cd37032717dcc1d093d7c
end
