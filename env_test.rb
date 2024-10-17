require "dotenv/load"

#pp ENV.fetch("GMAPS_KEY")
#pp ENV.fetch("OPENAI_KEY")

#gem install http (si tienes gemfile no necesitas instalarlo ahora)

gmaps_api_key = ENV.fetch("GMAPS_KEY")
openai_api_key = ENV.fetch("OPENAI_KEY")
pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")


#Ask the user for their location. (Recall gets.) Get and store the user’s location.

require "http"
require "json"
require "dotenv/load"

pp "Where are you?"
location = gets.chomp
#pp location

#Get the user’s latitude and longitude from the Google Maps API.

google_maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{gmaps_api_key}"
raw_response_maps = HTTP.get(google_maps_url)
parsed_response_maps = JSON.parse(raw_response_maps)

#pp parsed_response_maps.keys

latitude = parsed_response_maps.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lat")
#pp latitude
longitude = parsed_response_maps.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lng")
#pp longitude

pirate_weather_url = "https://api.pirateweather.net/forecast/#{pirate_weather_api_key}/#{latitude},#{longitude}"
raw_response_pirate = HTTP.get(pirate_weather_url)
parsed_response_pirate = JSON.parse(raw_response_pirate)

#pp parsed_response_pirate

#pp parsed_response_pirate.keys

temp = parsed_response_pirate.fetch("currently").fetch("temperature")
pp "Your current temperature is #{temp} F°"
