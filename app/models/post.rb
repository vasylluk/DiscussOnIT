class Post < ApplicationRecord
	belongs_to :user

    def all_tags
    	Tag.where(resource_type: "post", resource_id: self.id).map{|tag| tag = Category.find(tag.category_id)}.map(&:name).join(', ')
    end

    def all_tags=(names)
    	q = names.split(',').map do |name|
                name.strip.downcase  
            end
        q.delete("")

        cat = q.to_set
        cat.map do |name|
                category = Category.where(name: name).first_or_create!
                tag =Tag.where(category_id: category.id, resource_type: "post", resource_id: self.id).first_or_create!
                if tag.resource_id==nil
                	tag.destroy
                end
        end
        Tag.where(resource_type: "post", resource_id: self.id).map{|tag|
            if not cat.include?(Category.find(tag.category_id).name)
                tag.destroy
            end
        }
    end
end
