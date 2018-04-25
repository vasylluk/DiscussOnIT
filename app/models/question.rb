class Question < ApplicationRecord
    after_update :question_update

	belongs_to :user

	has_many :tags
	has_many :categories, through: :tags
	has_many :answers, dependent: :destroy
	has_many :chosen_questions, dependent: :destroy
	has_many :qcomments, dependent: :destroy

    validates :name, :text, presence: true

    def all_categories
    	self.categories.map(&:name).join(', ')
    end

    def all_categories=(names)
    	q = names.split(',').map do |name|
                name.strip
            end
        q.delete("")
        self.categories = q.map do |name|
                Category.where(name: name).first_or_create!
                
        end
    end


    def question_update
    end
end
