class Question < ApplicationRecord
    after_update :question_update

	belongs_to :user

	has_many :answers, dependent: :destroy
	has_many :chosen_questions, dependent: :destroy
	has_many :qcomments, dependent: :destroy

    validates :name, :text, presence: true

    def question_update
    end
end
