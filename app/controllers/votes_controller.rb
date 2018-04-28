class VotesController < ApplicationController
	before_action :authenticate_user!
	before_action :get_object

	def positiv_vote
		if current_user.id != @object.user.id
			@vote=Vote.find_by(user_id: current_user.id,resource_type: @object.class.name,resource_id: @object.id)
		if @vote==nil
			@vote=Vote.create(user_id: current_user.id,resource_type: @object.class.name,resource_id: @object.id,score: 1)
	    else
	    	if @vote.score == -1
	    	    @vote.update(score: 0)
	        else
	        	@vote.update(score: 1)
	        end
	    end
	    @object.update(score: Vote.where(resource_type: @object.class.name,resource_id: @object.id).sum(:score))
		end
	    redirect_back(fallback_location: root_path)
	end

	def negativ_vote
		if current_user.id != @object.user.id
		@vote=Vote.find_by(user_id: current_user.id,resource_type: @object.class.name,resource_id: @object.id)
		if @vote==nil
		    @vote=Vote.create(user_id: current_user.id,resource_type: @object.class.name,resource_id: @object.id,score: -1)
	    else
	    	if @vote.score == 1
	    	    @vote.update(score: 0)
	        else
	        	@vote.update(score: -1)
	        end
	    end
	    @object.update(score: Vote.where(resource_type: @object.class.name,resource_id: @object.id).sum(:score))
		end
	    redirect_back(fallback_location: root_path)
	end

	private

	def get_object
		pp @object=params[:type].constantize.find(params[:id])
	end

end
