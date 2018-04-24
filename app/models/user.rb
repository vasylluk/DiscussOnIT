class User < ApplicationRecord
   	after_create :create_userparam

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   	has_one :userparam, dependent: :destroy

  	has_many :questions
  	has_many :answers

  	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/default.png"
  	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/


private

def create_userparam
   	@userparam=Userparam.create(user_id: self.id)
   	@userparam.save
end

end
