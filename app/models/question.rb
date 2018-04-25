class Question < ApplicationRecord
    after_update :question_update

	belongs_to :user

	has_many :answers, dependent: :destroy
	has_many :chosen_questions, dependent: :destroy
	has_many :qcomments, dependent: :destroy

    validates :name, :text, presence: true

    def all_tags
    	Tag.where(resource_type: "question", resource_id: self.id).map{|tag| tag = Category.find(tag.category_id)}.map(&:name).join(', ')
    end

    def all_tags=(names)
    	q = names.split(',').map do |name|
                name.strip.downcase  
            end
        q.delete("")

        cat = q.to_set
        cat.map do |name|
                category = Category.where(name: name).first_or_create!
                Tag.where(category_id: category.id, resource_type: "question", resource_id: self.id).first_or_create!
        end
    end


    def question_update
    end
end
