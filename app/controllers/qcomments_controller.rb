class QcommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_qcomment, only:[:update,:destroy]

	def create
		params[:qcomment][:user_id]=current_user.id
		params[:qcomment][:question_id]=params[:question_id]
		@qcomment=Qcomment.create(qcomment_params)
		if @qcomment.save
			redirect_to question_path(@qcomment.question.id)
		else
			render 'new'
		end
	end

	def update
		@qcomment.update(qcomment_params)
		redirect_to question_path(@qcomment.question.id)
	end

	def destroy
		@question=Question.find(@qcomment.question.id)
		@qcomment.destroy
		redirect_to question_path(@question.id)
	end

	private

	def qcomment_params
		params.require(:qcomment).permit(:user_id,:question_id, :text)
	end

	def set_qcomment
		@qcomment=Qcomment.find(params[:id])
	end
end
