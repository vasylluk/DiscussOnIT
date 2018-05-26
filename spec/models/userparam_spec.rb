require "rails_helper"
 
RSpec.describe Userparam, :type => :model do
let!(:user){create(:user)}

subject{
   build(:userparam, user: user)
}

  context "validation" do
     it "is valid with valid attributes" do
       expect(subject).to be_valid
     end
  end

 context "when user phone is not right format" do
    it "should not be valid" do
    subject.phone = "12345678"
    expect(subject).to_not be_valid
 end
 end
  context "association" do
     it { should belong_to(:user) }
  end

end