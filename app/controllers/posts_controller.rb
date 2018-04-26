class PostsController < ApplicationController
	before_action :authenticate_user!, except:[:index,:show]
	before_action :get_post, only:[:show,:edit,:update,:destroy,:positiv_vote,:negativ_vote]

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
      @post.update(view: @post.view+1)
  		@postcomments= Postcomment.where(post_id: @post.id)
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

    def positiv_vote
    if current_user.id != @post.user.id
    @vote=PostVote.where(user_id: current_user.id,post_id: @post.id).first
    @user=Userparam.find(@post.user.userparam.id)
    @user.update(karma: @user.karma-@post.score)
    if @vote==nil
        @vote=PostVote.create(user_id: current_user.id, post_id: @post.id, score: 1)
      else
        if @vote.score == -1
          @vote.update(score: 0)
        else
          @vote.update(score: 1)
        end
      end
      @post.update(score: PostVote.where(post_id: @post.id).sum(:score))
      @user.update(karma: @user.karma+@post.score)
      @user.save
    end
      redirect_back(fallback_location: root_path)
  end

  def negativ_vote
    if current_user.id != @post.user.id
    @vote=PostVote.where(user_id: current_user.id,post_id: @post.id).first
    @user=Userparam.find(@post.user.userparam.id)
    @user.update(karma: @post.user.karma-@post.score)
    if @vote==nil
        @vote=PostVote.create(user_id: current_user.id, post_id: @post.id, score: -1)
      else
        if @vote.score == 1
          @vote.update(score: 0)
        else
          @vote.update(score: -1)
        end
      end
      @post.update(score: PostVote.where(post_id: @post.id).sum(:score))
      @user.update(karma: @user.karma-@post.score)
      @user.save
    end
      redirect_back(fallback_location: root_path)
  end

  	private

  	def post_params
  		params.require(:post).permit(:user_id,:title,:body)
  	end

  	def get_post
  		@post = Post.find(params[:id])
  	end
end
