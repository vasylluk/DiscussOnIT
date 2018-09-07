class PagesController < ApplicationController

  	def index
	    @questions = @q.result(distinct: true)
	    @posts= Post.ransack(params[:q]).result(distinct: true)
  	end

  	def users_rat
  		@users_rat= Userparam.all.order(karma: :DESC).page(params[:page]).per(100)
  	end

end
