class QuestionsController < ApplicationController
	before_action :authenticate_user!, except:[:index,:show]
	before_action :set_question, only:[:show,:edit,:update,:destroy,:chosen,:positiv_vote,:negativ_vote]

	def index
		@questions=Question.all.order(created_at: :DESC)
	    @q = Question.ransack(params[:q])
	    @squestios = @q.result(distinct: true)
	end

	def show
		@answers=Answer.where(question_id: @question.id).order(right: :DESC,score: :DESC)
		@qcomments=Qcomment.where(question_id: @question.id)
		@question.update(view: @question.view+1)
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

	def positiv_vote
		if current_user.id != @question.user.id
		@vote=QuestionVote.where(user_id: current_user.id,question_id: @question.id).first
		@user=Userparam.find(@question.user.userparam.id)
		@user.update(karma: @user.karma-@question.score)
		if @vote==nil
		    @vote=QuestionVote.create(user_id: current_user.id, question_id: @question.id, score: 1)
	    else
	    	if @vote.score == -1
	    	    @vote.update(score: 0)
	        else
	        	@vote.update(score: 1)
	        end
	    end
	    @question.update(score: QuestionVote.where(question_id: @question.id).sum(:score))
	    @user.update(karma: @user.karma+@question.score)
	   	@question.user.save
		end
	    redirect_back(fallback_location: root_path)
	end

	def negativ_vote
		if current_user.id != @question.user.id
		@vote=QuestionVote.where(user_id: current_user.id,question_id: @question.id).first
		@user=Userparam.find(@question.user.userparam.id)
		@user.update(karma: @user.karma-@question.score)
		if @vote==nil
		    @vote=QuestionVote.create(user_id: current_user.id, question_id: @question.id, score: -1)
	    else
	    	if @vote.score == 1
	    	    @vote.update(score: 0)
	        else
	        	@vote.update(score: -1)
	        end
	    end
	    @question.update(score: QuestionVote.where(question_id: @question.id).sum(:score))
	    @user.update(karma: @user.karma+@question.score)
	    @question.user.save
		end
	    redirect_back(fallback_location: root_path)
	end

	def chosen
		
		if @chosen=ChosenQuestion.find_by(user_id: current_user.id, question_id: @question.id)
		    @chosen.delete
		else
		   @chosen=ChosenQuestion.create(user_id: current_user.id,question_id: @question.id)
		end
		redirect_to question_path(@question.id)
	end

	def chosens
		@questions=[]
		ChosenQuestion.where(user_id: current_user.id).each do |chosen|
			@questions<<chosen.question
		end

	end

	private

	def question_params
		params.require(:question).permit(:user_id,:name,:text,:answers,:score)
	end

	def set_question
		@question=Question.find(params[:id])
	end
end
