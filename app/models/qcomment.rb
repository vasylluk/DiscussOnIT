class Qcomment < ApplicationRecord
	after_create :qcomment_create

	belongs_to :user
	belongs_to :question

	private

		def qcomment_create
    		@chosens = ChosenQuestion.where(question_id: self.question.id)
    		@chosens.each do |chose|
    			#if chose.user_id != current_user.id
    			@noti = Notification.create(user_id: chose.user_id,resource_type:"question", text: "New comment to question "+self.question.name, resource_id:self.question.id)
    			@noti.save
    			#end
    		end
    	end
end
