class User < ActiveRecord::Base

	def get_stories
		response = RestClient.get("http://reddit.com/top.json?limit=5")
		parsed_response = JSON.parse(response)
		story_hashes = parsed_response['data']['children']

		story_hashes.each do |story_hash|
			reddit_story = Story.new(:title => story_hash['data']['title'], 
				:score => story_hash['data']['score'])
			reddit_story.save
		end
	end

end