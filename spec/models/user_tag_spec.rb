require 'rails_helper'

RSpec.describe UserTag, type: :model do
let!(:user){create(:user)}
  subject{
		build(:user_tag, user: user)
	}
    describe "validation" do
      it "is not valid without category_id" do
        subject.category_id = nil
        expect(subject).to_not be_valid
      end
      it "is not valid without user_id" do
        subject.user_id = nil
        expect(subject).to_not be_valid
      end
  end

 	context "association" do
      it { should belong_to(:user) }
      it { should belong_to(:category) }
  	end

end
