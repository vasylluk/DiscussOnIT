class Question < ApplicationRecord
    after_update :question_update
    before_destroy :question_destroy
    
	belongs_to :user

	has_many :answers, dependent: :destroy
	has_many :chosen_questions, dependent: :destroy
	has_many :qcomments, dependent: :destroy

    validates :name, :text, presence: true

    def all_tags
    	Tag.where(resource_type: self.class.name, resource_id: self.id).map{|tag| tag = Category.find(tag.category_id)}.map(&:name).join(', ')
    end

    private

        def question_update
            @chosens = ChosenQuestion.where(question_id: self.id)
            @chosens.each do |chose|
                @noti = Notification.create(user_id: chose.user.id, resource_type:self.class.name, text: "Update question ", resource_id:self.id)
                @noti.save
            end
        end

        def question_destroy
            Vote.where(resource_type: self.class.name, resource_id: self.id).each do |vote|
                vote.destroy()
            end
            @chosens = ChosenQuestion.where(question_id: self.id)
            @chosens.each do |chose|
                @noti = Notification.create(user_id: chose.user.id, resource_type:self.class.name, text: "Delet question ", resource_id:self.id)
                @noti.save
            end
        end

end
