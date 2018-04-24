class UserparamsController < ApplicationController
	before_action :authenticate_user!, except:[:index,:show]
	before_action :get_userparam,except:[:notifications]

	def show
		
	end

	def edit
		
	end

	def update
		@userparam.update(userparam_params)
		redirect_to userparam_path(@userparam.id)
	end

	def notifications
		@notifications = Notification.where(user_id: current_user.id)
	end

	private

	def userparam_params
		params.require(:userparam).permit(:user_id,:avatar,:bio,:country,:univ,:phone)
	end

	def get_userparam
		@userparam=Userparam.find(current_user.userparam.id)
	end
end
