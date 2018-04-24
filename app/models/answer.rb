class Answer < ApplicationRecord
	after_create :answer_create
	belongs_to :question
	belongs_to :user
	has_many :answer_votes, dependent: :destroy
	has_many :anscomments, dependent: :destroy
    validates :text, presence: true

    private
    	
    	def answer_create
    		@chosens = ChosenQuestion.where(question_id: self.question.id)
    		@chosens.each do |chose|
    			#if chose.user_id != current_user.id
    				Notification.create(user_id: chose.user_id, text: "New answer to question")
    			#end
    		end
    	end
	
end
