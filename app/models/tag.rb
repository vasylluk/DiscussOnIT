class Tag < ApplicationRecord
	belongs_to :category

    def all_tags_c(object, names)
    	q = names.split(',').map do |name|
                name.strip.downcase  
            end
        q.delete("")

        cat = q.to_set
        cat.map do |name|
                category = Category.where(name: name).first_or_create!
                tag =Tag.where(category_id: category.id, resource_type: object.class.name, resource_id: object.id).first_or_create!
        end
        Tag.where(resource_type: object.class.name, resource_id: object.id).map{|tag|
            if not cat.include?(Category.find(tag.category_id).name)
                tag.destroy
            end
        }
    end

    def all_tags_w(object)
    	Tag.where(resource_id: object.id, resource_type: object.class.name).map{|tag| 
    		tag = tag.category
    		}
    end
end
