class Story < ActiveRecord::Base
	def self.get_stories
		# get stories from the API
		response = RestClient.get("http://reddit.com/top.json?limit=5")
		parsed_response = JSON.parse(response)
		story_hashes = parsed_response['data']['children']

		# delete all existing stories
		Story.delete_all

		# download and save new stories to database
		story_hashes.each do |story_hash|
			Story.new(
				:title => story_hash['data']['title'], 
				:score => story_hash['data']['score']
			).save
		end

		# return all the current stories
		Story.all
	end
end