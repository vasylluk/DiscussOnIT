require "rails_helper"
 
RSpec.describe User, type: :model do

subject{
   FactoryBot.build(:user)
}

describe "validation" do
  it "is valid with valid attributes" do
    expect(subject).to be_valid
end

  it "should not be valid without nickname" do
     subject.nickname = nil
     expect(subject).to_not be_valid
end
end
 
 context "when user nickname is not right format" do
    it "should not be valid" do
    subject.nickname = "^top^"
    expect(subject).to_not be_valid
 end
end
describe "associations" do
    it { should have_one(:userparam).dependent(:destroy) }
    it { should have_many(:questions).dependent(:destroy) }
    it { should have_many(:qcomments).dependent(:destroy) }
    it { should have_many(:chosen_questions).dependent(:destroy) }
    it { should have_many(:answers).dependent(:destroy) }
    it { should have_many(:anscomments).dependent(:destroy) }
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:postcomments).dependent(:destroy) }
    it { should have_many(:reports).dependent(:destroy) }
    it { should have_many(:votes).dependent(:destroy) }
    it { should have_many(:notifications).dependent(:destroy) }
    it { should have_many(:user_tags).dependent(:destroy) }
end
end
