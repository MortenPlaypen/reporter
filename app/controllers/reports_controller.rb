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
			#binding.pry
		end
		if @reports.first.satisfaction == true
			# get satisfaction
			results = @zendesk_client.search(query: "type:satisfaction_rating created_at>#{Date.today - 30.to_i}")
			# result = @zendesk_client.satisfaction_ratings.find!(:created_at => "#{Date.yesterday}") #(query: "type:satisfaction_rating closed>#{Date.today - 30.to_i}")
			# binding.pry

			results.each do |satisfaction_rating|
      			# binding.pry
      			satisfaction_rating = {
          			subject: ticket[:subject],
          			description: ticket[:description]
      			}
			end
			if results == nil
				@satisfaction = "No satisfaction"
			else
				@satisfaction = "Some satisfaction"
			end

			# loop through tickets that have satisfaction to find satisified percentage
			
		end
		if @reports.first.first_response_time == true
			# get response time
			results = @zendesk_client.search(query: "type:ticket created>#{Date.today - 30.to_i}")
			#results = @zendesk_client.search(query: "type:ticket status:solved")
			tickets = []
			@reply_time = 0
			count = 0
			#binding.pry

			results.each do |ticket|
				#binding.pry
				if ticket.metrics[:replies] > 0 then
					response_ticket = {
	          			ticket_reply_time: ticket.metrics[:reply_time_in_minutes][:calendar],
	          			replies: ticket.metrics[:replies] #description: ticket[:description]
	          		}
					tickets << response_ticket
					@reply_time = @reply_time+ticket.metrics[:reply_time_in_minutes][:calendar]
					count = count + 1
					# binding.pry
				end
			end
			@reply_time = @reply_time/count

		end
		if @reports.first.resolution_time == true
			# get resolution time
			tickets = @zendesk_client.search(query: "type:ticket created>#{Date.today - 30.to_i}")
		end
		if @reports.first.top_tags == true
			# get top tags
		end

	end

	def report_params
		params.require(:report).permit(:volume, :satisfaction, :first_response_time, :resolution_time, :top_tags)
	end

end