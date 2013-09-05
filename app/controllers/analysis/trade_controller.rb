class Analysis::TradeController < ApplicationController
	
	# / GET
	def index
		@year = 2013
		@results = Auction::Trade.find_success_trade_users(@year).paginate :page => params[:page]
	end
end
