class Story < ActiveRecord::Base
	# We've modified this method to return different
	# results depending on the type, feed and limit
	def self.get_stories(type, feed, limit)
		base = "http://reddit.com"
		feed = "/r/#{feed}" if !feed.blank?

		# Whitelisting
		possible_types = ["hot", "top"]
		if possible_types.include? type
			url = "#{base}#{feed}/#{type}.json"
		else
			url = "#{base}#{feed}/new.json"
		end

		if !limit.blank? 
			url = url + "?limit=#{limit}"
		end

		# Common debugging technique: check for this output in
		# rails server output
		puts "\n\n\n"
		puts url
		puts "\n\n\n"
		# get stories from the API
		response = RestClient.get(url)
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
