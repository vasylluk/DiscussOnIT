class Post < ApplicationRecord
	before_destroy :post_destroy

	belongs_to :user

	has_many :postcomments, dependent: :destroy

	validates :name, :text, presence: true

	def all_tags
    	Tag.where(resource_type: self.class.name, resource_id: self.id).map{|tag| tag = Category.find(tag.category_id)}.map(&:name).join(', ')
    end

    private

    def post_destroy
    	Vote.where(resource_type: self.class.name, resource_id: self.id).each do |vote|
            vote.destroy()
        end
    end
end
