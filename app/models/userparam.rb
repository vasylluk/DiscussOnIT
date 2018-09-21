class Userparam < ApplicationRecord
	belongs_to :user
	validates :bio, 
			allow_blank: true, 
			length: 5..255
	validates :phone,
			allow_blank: true, 
            uniqueness: true,
            length: { is: 13 },
            format: {with: /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/}
	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/default.png"
  	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
