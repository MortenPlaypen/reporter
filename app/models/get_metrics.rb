require 'zendesk_api'
#require 'httparty'

module GetMetrics
	#include HTTParty
	#include 'zendesk_api'

	def self.get_metrics(current_user)

		# curl https://playpenlabs.zendesk.com/api/v2/users/me.json -v -u morten@playpenlabs.com:playpenlabs

		ret_hash = {}
		last_week = 42
		ret_hash = { :last_week => last_week }
		return ret_hash
	end

	#require 'zendesk_api'

	class ZendeskClient < ZendeskAPI::Client

		def self.instance
			@instance = ZendeskAPI::Client.new do |config|
			  # Mandatory:

			  config.url = "https://playpenlabs.zendesk.com" # e.g. https://mydesk.zendesk.com/api/v2

			  # Basic / Token Authentication
			  config.username = "morten@playpenlabs.com"

			  # Choose one of the following depending on your authentication choice
			  #config.token = "your zendesk token"
			  config.password = "playpenlabs"

			  # OAuth Authentication
			  #config.access_token = "your OAuth access token"

			  # Optional:

			  # Retry uses middleware to notify the user
			  # when hitting the rate limit, sleep automatically,
			  # then retry the request.
			  config.retry = true

			  # Logger prints to STDERR by default, to e.g. print to stdout:
			  require 'logger'
			  config.logger = Logger.new(STDOUT)
			  
			  # Changes Faraday adapter
			  # config.adapter = :patron

			  # Merged with the default client options hash
			  # config.client_options = { :ssl => false }

			  # When getting the error 'hostname does not match the server certificate'
			  # use the API at https://yoursubdomain.zendesk.com/api/v2
			end
		end
	end
end
