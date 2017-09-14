include Weathers

describe CurrentWeather do

	before(:all) do
		#Generate random captial city
		@generator = Generator::RandomCountryGenerator.new
        @generator.generate_country
		#Obtaining weather json object
		@current_weather = Weathers::CurrentWeather.new(@generator.capital_name,@generator.country_code)
	end

	it 'should return matching country code and city name' do
		expect(@current_weather.get_single_body['name'].delete(' ')).to eq @generator.capital_name
		expect(@current_weather.get_single_body['sys']['country']).to eq @generator.country_code
	end

	it 'should return a current weather JSON object with at most 12 main keys' do
		expect(@current_weather.get_single_body.keys.length).to be_between(11,12)
	end

	it 'should return coordinates that are a Hash, with longitude an latitude floats' do
		expect(@current_weather.get_single_body['coord']).to be_a(Hash)
		expect(@current_weather.get_single_body['coord']['lon']).to be_a(Float)
		expect(@current_weather.get_single_body['coord']['lat']).to be_a(Float)
	end

	it 'should return a weather array' do
		expect(@current_weather.get_single_body['weather']).to be_a(Array)
	end

	it 'should return Hashes inside the weather array that has description that matches to their id number' do

	end

	it "should be an integer for id" do 
		expect(@current_weather.get_single_body['id']).to be_kind_of(Integer)
	end

	it "should have 8 digits in id" do 
		expect(@current_weather.get_single_body['id'].size).to equal(8)
	end

	it "should have matching capital city name to returned JSON file" do 
		expect(@current_weather.get_single_body['name']).to eql(@generator.capital_name)
	end

	it "should have response code of 200" do 
		expect(@current_weather.get_single_response_code).to equal(200)
	end

end