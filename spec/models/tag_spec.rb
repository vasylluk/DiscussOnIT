require 'rails_helper'

RSpec.describe Tag, type: :model do

  subject{
		build(:tag)
	}
    describe "validation" do
      it "is not valid without category_id" do
        subject.category_id = nil
        expect(subject).to_not be_valid
      end
  end
	context "association" do
     it { should belong_to(:category) }
  end

end
