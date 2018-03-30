class Anscomment < ApplicationRecord
	belongs_to :user
	belongs_to :answer
    validates :text, presence: true
end
