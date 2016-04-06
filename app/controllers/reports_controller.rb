class ReportsController < ApplicationController
	before_filter :authenticate_user!, :create_zendesk_client
	include GetMetrics

	def index
		@content = GetMetrics.get_metrics(current_user)
		@report=Report.new
		@reports = current_user.reports
		self.get_metrics
	end

	def create
		@report=current_user.reports.create(report_params)
  		redirect_to :root
	end

	def create_zendesk_client
		# call to get_metrics to create and return instance
		@zendesk_client ||= ZendeskClient.instance
	end

	def get_metrics
		if @reports.first.volume == true
			# get volume
			tickets = @zendesk_client.search(query: "type:ticket created>#{Date.today - 30.to_i}")
			@volume = tickets.count
		end
		if @reports.first.satisfaction == true
			# get satisfaction
			tickets = @zendesk_client.search(query: "type:ticket closed>#{Date.today - 30.to_i}")
			ratings = tickets.count
		end
		if @reports.first.first_response_time == true
			# get response time
		end
		if @reports.first.resolution_time == true
			# get resolution time
		end
		if @reports.first.top_tags == true
			# get top tags
		end

	end

	def report_params
		params.require(:report).permit(:volume, :satisfaction, :first_response_time, :resolution_time, :top_tags)
	end

end