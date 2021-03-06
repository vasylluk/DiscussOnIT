class Qcomment < ApplicationRecord
	after_create :qcomment_create
    before_destroy :qcomment_destroy

	belongs_to :user
	belongs_to :question

    validates :text, presence: true, length: 5..64

	private

		def qcomment_create
    		@chosens = ChosenQuestion.where(question_id: self.question.id)
    		@chosens.each do |chose|
    			@noti = Notification.create(user_id: chose.user_id,resource_type: self.question.class.name, text: "Comment to question ", resource_id:self.question.id)
    			@noti.save
    		end
    	end

        def qcomment_destroy
            @chosens = ChosenQuestion.where(question_id: self.question.id)
            @chosens.each do |chose|
                @noti = Notification.create(user_id: chose.user_id,resource_type: self.question.class.name, text: "Delet comment to question ", resource_id:self.question.id)
                @noti.save
            end
        end
end
