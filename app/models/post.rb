class Post < ApplicationRecord
	belongs_to :user

	has_many :postcomments

	validates :title, :body, presence: true

	def all_tags
    	Tag.where(resource_type: self.class.name, resource_id: self.id).map{|tag| tag = Category.find(tag.category_id)}.map(&:name).join(', ')
    end
end
