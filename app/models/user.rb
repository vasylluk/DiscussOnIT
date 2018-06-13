class User < ApplicationRecord
   	after_create :create_userparam, :welcome_send

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    #validations
    validates :nickname, presence: true, length: 5..15, uniqueness: true, format: { without: /[!-\/\@\^\~\`\(\)\[\]\>\<\=]/ }
   	
    has_one :userparam, dependent: :destroy

  	has_many :questions,dependent: :destroy
    has_many :qcomments,dependent: :destroy
    has_many :chosen_questions,dependent: :destroy

  	has_many :answers,dependent: :destroy
    has_many :anscomments,dependent: :destroy

    has_many :posts,dependent: :destroy
    has_many :postcomments,dependent: :destroy

    has_many :reports,dependent: :destroy

    has_many :notifications,dependent: :destroy

    has_many :votes,dependent: :destroy

    has_many :user_tags ,dependent: :destroy

  def welcome_send
    WelcomeMailer.welcome_email(self).deliver
  end

private

  def create_userparam
   	@userparam=Userparam.create(user_id: self.id)
   	@userparam.save
  end

end
