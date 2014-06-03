class StoriesController < ApplicationController
	def index
		@stories = Story.get_stories
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