#require 'bundler/setup'

require 'sinatra/base'
require 'busgogo'
require 'json'
# require './tutorial'
require_relative 'model/busgogo'


require 'bundler/setup'
require 'haml'
require 'sinatra/flash'

class Bus < Sinatra::Base
	enable :sessions
	register Sinatra::Flash

	configure :production, :development do
		enable :logging
	end

	configure :development do
		set :session_secret, "something"
 	end
	helpers do
		def user
		
			num = params[:num].to_i			
			return nil unless num

			profile_after={
		 		'station' => num,
				'profiles' => 'not yet found',
				'data'  => [],	
				'stop' => [],
				'address' => []			
			}
			# data_info={
				
			# }

			begin
				buses = WebScraper.new
				stations = buses.busstation
				profile_after['profiles'] = stations[num]
				
				busess = WebScraper.new
				adr = busess.selectdropdown('http://www.hcbus.com.tw/big5/service.asp',num-1)
				logger.info("Found: #{adr}")

				adr.each do |name,tmp_adr|
				profile_after['data'].push('stop' => name,'adr' => tmp_adr)
				profile_after['stop'].push(name)
				profile_after['address'].push(tmp_adr)
					end
			
				
			rescue
				return nil
			end
			profile_after
		
		end



                 def new_tutorial(req)
                 tutorial = Busgogo.new
                 tutorial.num = req['num'].to_json
                 tutorial.station = req['station'].to_json
				tutorial.address = req['address'].to_json
                 tutorial
                 end
	end


	get '/' do
		 'Busgogo service is working at homepage'
	end

	get '/station' do
		'Busgogo service is working at station homepage'
	end

	#get '/station/*?' do
	#	'Busgogo service is working at station page'
	#end


	post '/api/v1/tutorials' do
		content_type :json
			begin
				req = JSON.parse(request.body.read)
				logger.info req
			rescue
				halt 400
         end
		#endTables: 0

			tutorial = Busgogo.new
			tutorial.num = req['num'].to_json
			tutorial.station = req['station'].to_json
			tutorial.address = req['address'].to_json
			if tutorial.save
				status 201
				redirect "/api/v1/tutorials/#{tutorial.id}"
			end
	end



	get '/api/v1/tutorials/:id' do
	 	content_type :json, 'charset' => 'utf-8'

	  begin
		  @tutorial = Busgogo.find(params[:id])
			num = @tutorial.num
			station = @tutorial.station
			address = @tutorial.address
			result = { num: num, station: station, address: address}.to_json
			logger.info("Found: #{result}")
			result
		rescue
			halt 400
		end
	end
      


	get '/api/v2/station/:num.json' do
		logger.info "API GET STATION"
		content_type :json

		# busgogo=Busgogo.new
		# busgogo.num=params[:num].to_i
		# busgogo.station=user['stop']
		# busgogo.address=user['address']
		# busgogo.save
		# logger.info "save num&station&address to AWS dynamo DB!!"
		
		#num = params[:num].to_i
		user.nil? ? halt(404) : user.to_json


		




	end

    post '/api/v2/tutorials' do
		content_type :json
		body = request.body.read
		logger.info body
		begin
			req = JSON.parse(body)
			logger.info req
		rescue Exception => e
			halt 400
		end
		tutorial = new_tutorial(req)
		if tutorial.save
			redirect "/api/v2/tutorials/#{tutorial.id}"
		end
	end


	get '/api/v2/tutorials/:id' do
		content_type :json
		
		begin
			tutorial = Busgogo.find(params[:id])
			#num = JSON.parse(tutorial.num)
			#station = JSON.parse(tutorial.station)
			#address = JSON.parse(tutorial.address)
		
			tutorial.save

			logger.info "!!!!#{tutorial.num}, #{tutorial.station},#{tutorial.address} "
         	result = [tutorial.station, tutorial.address].to_json
			

			
			logger.info "save num&station&address to AWS dynamo DB!!!!"
          
		rescue
			halt 400
		end
		result
	end
	delete '/api/v2/tutorials/:id' do
		Tutorial.destroy(params[:id])
       end
end

