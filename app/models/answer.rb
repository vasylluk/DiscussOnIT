class Answer < ApplicationRecord
	belongs_to :question
	belongs_to :user
	has_many :answer_votes, dependent: :destroy
	has_many :anscomments, dependent: :destroy
    validates :text, presence: true
end
