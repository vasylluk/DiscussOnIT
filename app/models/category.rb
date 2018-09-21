class Category < ApplicationRecord
	has_many :tags, dependent: :destroy

	has_many :user_tags ,dependent: :destroy
	
	validates :name, presence: true, length: 1..32
end
