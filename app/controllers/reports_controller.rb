class ReportsController < ApplicationController
	before_filter :authenticate_user!, :create_zendesk_client, :get_volume
	include GetMetrics

	def index
		@content = GetMetrics.get_metrics(current_user)
		@report=Report.new
		#@content = "HER!"
		#binding.pry
	end

	def create
		@report=current_user.reports.create(report_params)
  		redirect_to :root
	end

	def create_zendesk_client
		# call to get_metrics to create and return instance
	  @zendesk_client ||= ZendeskClient.instance
	end

	def get_volume
		result = @zendesk_client.tickets.recent #search(query: "type:ticket")
    	binding.pry
    	tickets = []
    	@info_hash = {}
    	result.each do |ticket|
      		binding.pry
      		ticket = {
        		subject: ticket[:subject],
        		description: ticket[:description]
     		}
     		tickets << ticket
     		#binding.pry
	    	end
	    @info_hash[:tickets] = tickets
	    #render json: @info_hash
	    #@info_hash = "TEST"

	end

	def report_params
		params.require(:report).permit(:volume, :satisfaction, :first_response_time, :resolution_time, :top_tags)
	end

end