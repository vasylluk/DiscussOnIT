class CategoriesController < ApplicationController

	def index
		@categories=Category.all
	end

	def show
		@category=Category.find_by(name: params[:id])
		@posts=Tag.where(category_id: @category.id,resource_type: "Post").map{|tag| tag=Post.find(tag.resource_id)}
		@questions=Tag.where(category_id: @category.id,resource_type: "Question").map{|tag| tag=Question.find(tag.resource_id)}
	end

end
