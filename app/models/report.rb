class Report < ApplicationRecord
	belongs_to :user

	validates :text, :type, presence: true
    validates :text, length: 8..256

end
