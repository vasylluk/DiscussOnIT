require 'rails_helper'

RSpec.describe Anscomment, type: :model do
let!(:user){create(:user)}
let!(:question){create(:question)}
let!(:answer){create(:answer)}
  subject{
		build(:anscomment)
	}
  	describe "validation" do
   		it "is valid with valid attributes" do
   			expect(subject).to be_valid
   		end
	end

	describe "associations" do
		it{ should have_one(:answer_id).dependent(:destroy)}
	end
end
    describe "validation" do
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
      it "is not valid without answer_id" do
        subject.answer_id = nil
        expect(subject).to_not be_valid
      end
      it "is not valid with too short text" do
        subject.text = "lol"
        expect(subject).to_not be_valid
      end
  end
  context "association" do
     it { should belong_to(:user) }
     it { should belong_to(:answer) }
  end
  
end
