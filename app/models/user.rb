class User < ApplicationRecord
   	after_create :create_userparam

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   	has_one :userparam, dependent: :destroy

  	has_many :questions,dependent: :destroy
  	has_many :answers,dependent: :destroy

private

  def create_userparam
   	@userparam=Userparam.create(user_id: self.id)
   	@userparam.save
    redirect_to edit_userparam_path(self.userparam.id)
  end

end
