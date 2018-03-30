class Category < ApplicationRecord
	has_many :tags
	has_many :questions, through: :tags
end
