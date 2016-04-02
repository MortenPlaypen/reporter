/require 'zendesk_api'/
/require 'httparty'/

class GetMetrics
	/include HTTParty/
	/include zendesk_api/

	def self.get_metrics(current_user)
		ret_hash = {}
		last_week = 42
		ret_hash = { :last_week => last_week }
		/binding.pry/
		return ret_hash
	end

end
