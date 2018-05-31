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
		if @answer.user.id == current_user.id
			@answer.update(answer_params)
		end
		redirect_to question_path(@answer.question.id)
	end

	def destroy
		if @answer.user.id == current_user.id
			@question=Question.find(@answer.question.id)
			@answer.destroy
			@question.update(count: @question.count-1)
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
