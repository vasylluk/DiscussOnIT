class QuestionsController < ApplicationController
	before_action :authenticate_user!, except:[:index,:show]
<<<<<<< HEAD
	before_action :set_question, only:[:show,:edit,:update,:destroy,:chosen]

	def index
		@questions=Question.all
=======
	before_action :set_question, only:[:show,:edit,:update,:destroy,:chosen,:positiv_vote,:negativ_vote]

	def index
		@questions=Question.all
	    @q = Question.ransack(params[:q])
	    @squestios = @q.result(distinct: true)
>>>>>>> d8d478cc919bde9fb16fdafd7e6e4d1f63d64487
	end

	def show
		@answers=Answer.where(question_id: @question.id).order(score: :DESC)
		@qcomments=Qcomment.where(question_id: @question.id)
		if current_user != nil
			@chosen=ChosenQuestion.where(user_id: current_user.id, question_id: @question.id).first
		end
	end

	def new
	end

	def create
		params[:question][:user_id]=current_user.id
		@question=Question.create(question_params)
		if @question.save
			ChosenQuestion.create(user_id: current_user.id,question_id: @question.id)
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

<<<<<<< HEAD
=======
	def positiv_vote
		@vote=QuestionVote.where(user_id: current_user.id,question_id: @question.id).first
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
	    redirect_back(fallback_location: root_path)
	end

	def negativ_vote
		@vote=QuestionVote.where(user_id: current_user.id,question_id: @question.id).first
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
	    redirect_back(fallback_location: root_path)
	end

>>>>>>> d8d478cc919bde9fb16fdafd7e6e4d1f63d64487
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
<<<<<<< HEAD
		params.require(:question).permit(:user_id,:all_categories,:name,:text,:answers)
=======
		params.require(:question).permit(:user_id,:all_categories,:name,:text,:answers,:score)
>>>>>>> d8d478cc919bde9fb16fdafd7e6e4d1f63d64487
	end

	def set_question
		@question=Question.find(params[:id])
	end
end
