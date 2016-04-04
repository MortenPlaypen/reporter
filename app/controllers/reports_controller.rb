class ReportsController < ApplicationController
	before_filter :authenticate_user!, :create_zendesk_client
	include GetMetrics

	def index
		@content = GetMetrics.get_metrics(current_user)
		@report=Report.new
		#@content = "HER!"
		#binding.pry
	end

	def create_zendesk_client
		# call to get_metrics to create and return instance
		@zendesk_client = ZendeskClient.instance()
	end

end