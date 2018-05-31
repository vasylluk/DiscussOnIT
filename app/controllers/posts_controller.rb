class PostsController < ApplicationController
	before_action :authenticate_user!, except:[:index,:show]
	before_action :get_post, only:[:show,:edit,:update,:destroy,:positiv_vote,:negativ_vote]

	def index
    @posts = Post.all.page(params[:page]).per(10)
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
      @post.view+=1
      @post.save
  		@postcomments= Postcomment.where(post_id: @post.id)
      Tag.where(resource_type: @post.class.name , resource_id: @post.id).each {|tag| 
        utag =UserTag.where(user_id: current_user.id, category_id:tag.category_id).first_or_create! 
        utag.update(score: utag.score+1)
      }
  	end

  	def edit
  		
  	end

  	def update
      if @post.user.id == current_user.id
  		  Tag.new.all_tags_c(@post,params[:post][:all_tags])
  		  @post.update(post_params)
      end
  		redirect_to post_path(@post.id)
  	end

  	def destroy
      if @post.user.id == current_user.id
  		  @post.destroy
      end
  		redirect_to root_path
  	end
    
  	private

  	def post_params
  		params.require(:post).permit(:user_id,:name,:text)
  	end

  	def get_post
  		@post = Post.find(params[:id])
  	end
end
