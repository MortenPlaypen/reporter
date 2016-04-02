class ReportsController < ApplicationController
	before_filter :authenticate_user!

	def index
		@content = GetMetrics.get_metrics(current_user)
		/@content = "HER!"/
		/binding.pry/
	end

end