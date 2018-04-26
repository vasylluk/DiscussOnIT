class PostcommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :get_postcomment, only:[:update,:destroy]

	def create
		params[:postcomment][:user_id]=current_user.id
		params[:postcomment][:post_id]=params[:post_id]
		@postcomment=Postcomment.create(postcomment_params)
		if @postcomment.save
			redirect_to post_path(@postcomment.post.id)
		else
			render 'new'
		end
	end

	def update
		@postcomment.update(postcomment_params)
		redirect_to post_path(@postcomment.post.id)
	end

	def destroy
		if current_user.id==@postcomment.user.id
		@postcomment.destroy
		end
		redirect_back(fallback_location: root_path)
	end

	private

	def postcomment_params
		params.require(:postcomment).permit(:user_id,:post_id, :text)
	end

	def get_postcomment
		@postcomment=Postcomment.find(params[:id])
	end
end
