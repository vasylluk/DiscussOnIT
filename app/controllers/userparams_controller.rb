class UserparamsController < ApplicationController
	before_action :authenticate_user!, except:[:index,:show]
	before_action :get_userparam,except:[:notifications,:show]

	def show
		@userparam= Userparam.find(params[:id])
	end

	def edit
		
	end

	def update
		@userparam.update(userparam_params)
		redirect_to userparam_path(@userparam.id)
	end

	def notifications
		@notifications = Notification.where(user_id: current_user.id).order(created_at: :DESC)
	end

	def notif_delet
		@notifications = Notification.where(user_id: current_user.id).map { |e|  e.delete }
		redirect_back(fallback_location: root_path)
	end

	private

	def userparam_params
		params.require(:userparam).permit(:user_id,:avatar,:bio,:country,:univ,:phone)
	end

	def get_userparam
		@userparam=Userparam.find(current_user.userparam.id)
	end
end
