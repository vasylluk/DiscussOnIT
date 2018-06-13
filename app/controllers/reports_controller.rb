class ReportsController < ApplicationController
	before_action :authenticate_user!
  
	def index
		@reports=Report.all.order(create_at: :DESC)
	end

  	def new
  	end

  	def create
  		params[:report][:user_id]=current_user.id
  		@report=Report.create(report_params)
  		if @report.save

  		else

  		end
  		redirect_to root_path
  	end

  	private

  	def report_params
  		params.require(:report).permit(:user_id,:kind_of,:text)
  	end
end
