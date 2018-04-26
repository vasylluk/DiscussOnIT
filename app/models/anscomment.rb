class Anscomment < ApplicationRecord
	after_create :anscomment_create

	belongs_to :user
	belongs_to :answer
    validates :text, presence: true

    private 

    	def anscomment_create
    		@chosens = ChosenQuestion.where(question_id: self.answer.question.id)
    		@chosens.each do |chose|
    			#if chose.user_id != current_user.id
    			@noti = Notification.create(user_id: chose.user_id,resource_type:"question", text: "New comment to answer "+self.text[0..20]+" to question ", resource_id:self.answer.question.id)
    			@noti.save
    			#end
    		end
    	end
end
