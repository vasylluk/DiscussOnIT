class Vote < ApplicationRecord
	before_destroy :vote_destroy
	belongs_to :user

	private

		def vote_destroy
			#потрібно буде протестувати ... можливо не працюватиме 
			@user=self.resource_type.constantize.find(self.resource_id).user.userparam
			@user.update(karma: @user.karma-self.score)
		end
end
