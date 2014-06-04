class StoriesController < ApplicationController

	# From GET /stories (check routes.rb)
	def index
		# The params hash is created by Rails to store
		# the parameters given by any forms in the view.
		# The keys (in this case :type, :feed and :limit)
		# are specified by the names of the inputs.
		@stories = Story.get_stories(params[:type],
			params[:feed], params[:limit])
	end

	# From POST /stories (check routes.rb)
	def filter
		@stories = Story.get_stories(params[:type],
			params[:feed], params[:limit])

		# Renders app/views/stories/index.html.erb
		#   instead of the default filter.html.erb
		render "index"
	end

	# NOTE: The code below was moved to a Story.get_stories
	# model method. Any code that does business logic should
	# be in the model, not the controller
	# This code is basically extracted from:
	# http://github.com/iexperience/stories

	# def refresh
	# 	Story.delete_all

	# 	response = RestClient.get("http://reddit.com/top.json?limit=5")
	# 	parsed_response = JSON.parse(response)
	# 	story_hashes = parsed_response['data']['children']

	# 	story_hashes.each do |story_hash|
	# 		reddit_story = Story.new(:title => story_hash['data']['title'], 
	# 			:score => story_hash['data']['score'])
	# 		reddit_story.save
	# 	end

	# 	redirect_to :action => :index
	# end
end
