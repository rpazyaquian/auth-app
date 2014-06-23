class StocksController < ApplicationController

	def index
		puts session[:session_id]
	end

	def lookup
		respond_to do |format|

			format.html {}

			format.js do
				@stocks_data = {}
				@valid_stocks = []
				@stocks = params[:symbol].upcase.gsub(/\s+/, "").split(',')

				@stocks.each do |symbol|

					begin

						query = StockQuote::Stock.quote(symbol)

						history_data = StockQuote::Stock.json_history(symbol, start_date = params[:start_date], end_date = params[:end_date], ['Date', 'Close'])

						stock_data = history_data['quote'].sort_by! { |k| k['Date'] }

						sma50(stock_data.reverse)
						sma200(stock_data.reverse)

						@valid_stocks.push(symbol)

						@stocks_data[symbol.upcase] = { data: stock_data.reverse }

					rescue NoMethodError => e
						@stocks_data[symbol.upcase] = { message: "#{symbol} is not a valid symbol."}
					end

				end

			end
		end
	end

	private

		def sma50(stock_series)

			unless stock_series.length <= 50

				(0..stock_series.length-51).each do |i|
					sma = 0
					stock_series[i..i+50].each do |val|
						sma += val['Close'].to_f
					end
					sma = (sma/50)
					stock_series[i]['SMA50'] = sma.round(2)
				end

			end

		end

		def sma200(stock_series)

			unless stock_series.length <= 200

				(0..stock_series.length-201).each do |i|
					sma = 0
					stock_series[i..i+200].each do |val|
						sma += val['Close'].to_f
					end
					sma = (sma/200)
					stock_series[i]['SMA200'] = sma.round(2)
				end

			end

		end

end