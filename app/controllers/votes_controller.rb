class VotesController < ApplicationController
	before_action :authenticate_user!
	before_action :get_object

	def positiv_vote
		if current_user.id != @object.user.id
			if @vote==nil
				@vote=Vote.create(user_id: current_user.id,resource_type: @object.class.name,resource_id: @object.id,score: 1)
	    	else	
	    		@object.score-=@vote.score
	    		@user.karma-=@vote.score
	    		if @vote.score == -1
	    	    	@vote.update(score: 0)
	        	else
	        		@vote.update(score: 1)
	        	end
	    	end
	    	@object.score+=@vote.score
	    	@object.save
	    	@user.karma+=@vote.score
	    	@user.save
	    	#@object.update(score: Vote.where(resource_type: @object.class.name,resource_id: @object.id).sum(:score))
		end
	    redirect_back(fallback_location: root_path)
	end

	def negativ_vote
		if current_user.id != @object.user.id
			if @vote==nil
		    	@vote=Vote.create(user_id: current_user.id,resource_type: @object.class.name,resource_id: @object.id,score: -1)
		    else
	    		@object.update(score: @object.score-@vote.score)
	    		@user.update(karma: @user.karma-@vote.score)
		    	if @vote.score == 1
		    	    @vote.update(score: 0)
	    	    else
	        		@vote.update(score: -1)
		        end
		    end
		   	@object.update(score: @object.score+@vote.score)
		    #@object.update(score: Vote.where(resource_type: @object.class.name,resource_id: @object.id).sum(:score))
		   	@user.update(karma: @user.karma+@vote.score)
		end
	    redirect_back(fallback_location: root_path)
	end

	private

	def get_object
		@object=params[:type].constantize.find(params[:id])
		@user=@object.user.userparam
		@vote=Vote.find_by(user_id: current_user.id,resource_type: @object.class.name,resource_id: @object.id)
	end

end
