class QuestionsController < ApplicationController
	before_action :authenticate_user!, except:[:index,:show]
	before_action :set_question, only:[:show,:edit,:update,:destroy,:chosen,:positiv_vote,:negativ_vote]

	def index
		if user_signed_in? && current_user.userparam.filter
     		question_s = Set.new
      		categories = UserTag.where(user_id: current_user.id).order(score: :DESC).map{|utag| utag=utag.category}
      		categories.map{|category| Tag.where(category_id: category.id, resource_type:"Question").each do|tag| question_s.add(tag.resource_id) end}
      		question_s = question_s.to_a
      		@questions =Question.order_as_specified(id: question_s).page(params[:page]).per(10)
    	else
			@questions = Question.all.page(params[:page]).per(10)
		end
	end

	def show
		@answers=Answer.where(question_id: @question.id).order(right: :DESC,score: :DESC)
		@qcomments=Qcomment.where(question_id: @question.id)
		@question.view+=1
		@question.save
		if user_signed_in?
			Tag.where(resource_type: @question.class.name , resource_id: @question.id).each {|tag| 
        		utag =UserTag.where(user_id: current_user.id, category_id:tag.category_id).first_or_create! 
        		utag.update(score: utag.score+1)
      		}
      	end
	end

	def new
	end

	def create
		params[:question][:user_id]=current_user.id
		@tags=params[:question][:all_tags]
		@question=Question.create(question_params)
		Tag.new.all_tags_c(@question,@tags)
		if @question.save
			ChosenQuestion.create(user_id: current_user.id,question_id: @question.id)
			redirect_to question_path(@question.id)
		else
			render 'new'
		end
	end

	def edit
		
	end

	def update
		if @question.user.id = current_user.id
			Tag.new.all_tags_c(@question,params[:question][:all_tags])
			@question.update(question_params)
		end
		redirect_to question_path(@question.id)
	end

	def destroy
		if @question.user.id = current_user.id
			@question.destroy
		end
		redirect_back(fallback_location: root_path)
	end

	def chosen
		
		if @chosen=ChosenQuestion.find_by(user_id: current_user.id, question_id: @question.id)
		    @chosen.delete
		else
		   	@chosen=ChosenQuestion.create(user_id: current_user.id,question_id: @question.id)
		   	@chosen.save
		   	@noti = Notification.create(user_id: @question.user.id, resource_type: @question.class.name, text: "New user Choosen your  question ", resource_id: @question.id)
        	@noti.save
		end
		redirect_to question_path(@question.id)
	end


	private

	def question_params
		params.require(:question).permit(:user_id,:name,:text,:answers,:score)
	end

	def set_question
		@question=Question.find(params[:id])
	end
end
