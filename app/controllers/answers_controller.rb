class AnswersController < ApplicationController
	before_action :authenticate_user!
	before_action :set_answer, except:[:create]

	def create
		@question=Question.find(params[:question_id])
		if current_user.id != @question.user.id
			params[:answer][:user_id]=current_user.id
			params[:answer][:question_id]=params[:question_id]
			@answer=Answer.create(answer_params)
			if @answer.save
       			@question.update(count: @question.count+1)
				redirect_to question_path(@answer.question.id)
			else
				render 'form'
			end
		else
			redirect_to question_path(params[:question_id])
		end

	end

	def update
		@answer.update(answer_params)
		redirect_to question_path(@answer.question.id)
	end

	def destroy
		@question=Question.find(@answer.question.id)
		@answer.destroy
		@question.update(count: @question.count-1)
		redirect_back(fallback_location: root_path)
	end

	def positiv_vote
		if current_user.id != @answer.user.id
		@vote=AnswerVote.where(user_id: current_user.id,answer_id: @answer.id).first
		@user=Userparam.find(@answer.user.userparam.id)
		@user.update(karma: @user.karma-@answer.score)
		if @vote==nil
		    @vote=AnswerVote.create(user_id: current_user.id, answer_id: @answer.id, score: 1)
	    else
	    	if @vote.score == -1
	    	    @vote.update(score: 0)
	        else
	        	@vote.update(score: 1)
	        end
	    end

	    @answer.update(score: AnswerVote.where(answer_id: @answer.id).sum(:score))
	    @user.update(karma: @user.karma+@answer.score)
	   	@user.save
	    end
	    redirect_back(fallback_location: root_path)
	end

	def negativ_vote
		if current_user.id != @answer.user.id
		@vote=AnswerVote.where(user_id: current_user.id,answer_id: @answer.id).first
		@user=Userparam.find(@answer.user.userparam.id)
		@user.update(karma: @user.karma-@answer.score)
		if @vote==nil
		    @vote=AnswerVote.create(user_id: current_user.id, answer_id: @answer.id, score: -1)
	    else
	    	if @vote.score == 1
	    	    @vote.update(score: 0)
	    	else
	    	    @vote.update(score:-1)
	        end
	    end

	    @answer.update(score: AnswerVote.where(answer_id: @answer.id).sum(:score))
	    @user.update(karma: @user.karma+@answer.score)
	    @user.save
		end
	    redirect_back(fallback_location: root_path)


	end

	def right
		
		if @answer.question.user.id== current_user.id
			@user=Userparam.find(@answer.user.userparam.id)
			if @answer.right
			@answer.update(right: false)
			@user.update(karma: @user.karma-100)
			else
			@answer.update(right: true)
			@user.update(karma: @user.karma+100)
			end
			@answer.save
		end
		redirect_to question_path(@answer.question.id)
	end

	private

	def answer_params
		params.require(:answer).permit(:user_id,:question_id,:text,:score)
	end

	def set_answer
		@answer=Answer.find(params[:id])
	end
end
