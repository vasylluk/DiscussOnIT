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
    			@noti = Notification.create(user_id: chose.user_id,resource_type:"question", text: "New answer to question ", resource_id:self.question.id)
    			@noti.save
    			#end
    		end
    	end
end
