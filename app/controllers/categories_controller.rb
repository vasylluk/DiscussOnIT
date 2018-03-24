class CategoriesController < ApplicationController

	def index
		@categories=Category.all
	end

	def show
		@category=Category.find_by(name: params[:id])
		@questions=Question.where(category_id: @category.id)
	end

end
