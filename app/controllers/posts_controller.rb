class PostsController < ApplicationController
	before_action :authenticate_user!, except:[:index,:show]
	before_action :get_post, only:[:show,:edit,:update,:destroy]

	def index
		@posts=Post.all
	end

  	def new

  	end

  	def create
  		params[:post][:user_id]=current_user.id
  		@tags=params[:post][:all_tags]
  		@post=Post.create(post_params)
  		Tag.new.all_tags_c(@post,@tags)
  		if @post.save
  			redirect_to post_path(@post.id)
  		else
  			render 'new'
  		end
  	end

  	def show
  		
  	end

  	def edit
  		
  	end

  	def update
  		Tag.new.all_tags_c(@post,params[:post][:all_tags])
  		@post.update(post_params)
  		redirect_to post_path(@post.id)
  	end

  	def destroy
  		@post.destroy
  		redirect_to root_path
  	end

  	private

  	def post_params
  		params.require(:post).permit(:user_id,:title,:body)
  	end

  	def get_post
  		@post = Post.find(params[:id])
  	end
end
