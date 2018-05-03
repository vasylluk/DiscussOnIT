class Category < ApplicationRecord
	has_many :tags, dependent: :destroy

	has_many :user_tags ,dependent: :destroy
	
	validates :name, presence: true
end
