class Question < ApplicationRecord
	belongs_to :user
	has_many :tags, dependent: :destroy
	has_many :categories, through: :tags
	has_many :answers, dependent: :destroy
	has_many :chosen_questions, dependent: :destroy
	has_many :qcomments, dependent: :destroy
    validates :name, :text, presence: true
    def all_categories
    	self.categories.map(&:name).join(', ')
    end

    def all_categories=(names)
    	self.categories = names.split(',').map do |name|
      	Category.where(name: name.strip).first_or_create!
    end
end
end
