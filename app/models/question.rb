class Question < ApplicationRecord
    after_update :question_update

	belongs_to :user

	has_many :answers, dependent: :destroy
	has_many :chosen_questions, dependent: :destroy
	has_many :qcomments, dependent: :destroy

    validates :name, :text, presence: true

    def all_tags
    	Tag.where(resource_type: self.class.name, resource_id: self.id).map{|tag| tag = Category.find(tag.category_id)}.map(&:name).join(', ')
    end

    def question_update
    end
end
