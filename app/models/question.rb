class Question < ApplicationRecord
	belongs_to :user
	belongs_to :category
	has_many :answers, dependent: :destroy
	has_many :chosen_questions, dependent: :destroy
	has_many :qcomments, dependent: :destroy
end
