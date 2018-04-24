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
    			@noti = Notification.create(user_id: chose.user_id,resource_type:"question", text: "New answer to question "+self.question.name, resource_id:self.question.id)
    			@noti.save
    			#end
    		end
    	end
	#@notification=Notification.create(user_id: current_user.id, text: "Ваше питання успішно додано", url: "http://localhost:3000/"+question_path(@question))
end
