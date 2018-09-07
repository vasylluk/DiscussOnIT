class Report < ApplicationRecord
	belongs_to :user

	validates :text, :kind_of, presence: true
    validates :text, length: 8..256

end
