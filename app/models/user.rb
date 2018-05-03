class User < ApplicationRecord
   	after_create :create_userparam

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   	has_one :userparam, dependent: :destroy

  	has_many :questions,dependent: :destroy
    has_many :qcomments,dependent: :destroy
    has_many :chosen_questions,dependent: :destroy

  	has_many :answers,dependent: :destroy
    has_many :anscomments,dependent: :destroy

    has_many :posts,dependent: :destroy
    has_many :postcommets,dependent: :destroy

    has_many :reports,dependent: :destroy

    has_many :notifications,dependent: :destroy

    has_many :votes,dependent: :destroy

    has_many :user_tags ,dependent: :destroy


private

  def create_userparam
   	@userparam=Userparam.create(user_id: self.id)
   	@userparam.save
  end

end
