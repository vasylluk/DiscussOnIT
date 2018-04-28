class Answer < ApplicationRecord
	after_create :answer_create
    after_update :answer_update

	belongs_to :question
	belongs_to :user

	has_many :anscomments, dependent: :destroy

    validates :text, presence: true

    private
    	
    	def answer_create
    		@chosens = ChosenQuestion.where(question_id: self.question.id)
    		@chosens.each do |chose|
    		  @noti = Notification.create(user_id: chose.user.id,resource_type:self.question.class.name, text: "New answer to question ", resource_id:self.question.id)
    		  @noti.save
    		end
    	end

        def answer_update
            @chosens = ChosenQuestion.where(question_id: self.question.id)
            @chosens.each do |chose|
              @noti = Notification.create(user_id: chose.user.id,resource_type:self.question.class.name, text: "Update answer ("+self.text[0..30]+") to question ", resource_id:self.question.id)
              @noti.save
            end
        end
end
