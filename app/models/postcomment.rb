class Postcomment < ApplicationRecord
	belongs_to :user
	belongs_to :post

	validates :text, presence: true, length: 5..100
end
