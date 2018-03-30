class AnscommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_anscomment, only:[:update,:destroy]

	def create
		params[:anscomment][:user_id]=current_user.id
		params[:anscomment][:answer_id]=params[:answer_id]
		@anscomment=Anscomment.create(anscomment_params)
		if @anscomment.save
			redirect_to question_path(@anscomment.answer.question.id)
		else
			render 'new'
		end
	end

	def update
		@anscommet.update(anscomment_params)
		redirect_to question_path(@anscomment.answer.question.id)
	end

	def destroy
		@answer=Answer.find(@anscomment.answer.id)
		@anscomment.destroy
		redirect_to question_path(params[:answer_id])
	end

	private

	def anscomment_params
		params.require(:anscomment).permit(:user_id,:answer_id, :text)
	end

	def set_anscomment
		@anscomment=Anscomment.find(params[:id])
	end

end
