class QuestionsController < ApplicationController
	before_action :authenticate_user!, except:[:index,:show]
	before_action :set_question, only:[:show,:edit,:update,:destroy, :chosen]

	def index
		@questions=Question.all
	end

	def show
		@answers=Answer.where(question_id: @question.id).order(score: :DESC)
	end

	def new
	end

	def create
		params[:question][:user_id]=current_user.id
		@question=Question.create(question_params)
		if @question.save
			redirect_to question_path(@question.id)
		else

		end
	end

	def edit
		
	end

	def update
		@question.update(question_params)
		redirect_to question_path(@question.id)
	end

	def destroy
		@question.destroy
		redirect_to root_path
	end

	def chosen
		@chosen=ChosenQuestion.where(question_id: @question.id).first
		if @chosen == nil
			@chosen.create(user_id: current_user.id,question_id: @question.id)
		else
		    @chosen.delete
		end
		redirect_to question_path(@question)
	end

	private

	def question_params
		params.require(:question).permit(:user_id,:category_id,:name,:text,:answers, :count)
	end

	def set_question
		@question=Question.find(params[:id])
	end
end
