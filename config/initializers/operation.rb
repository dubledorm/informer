require 'operation'
require 'open_weather_map_adapter'

unless Rails.env.test?
  Operation.setup do |config|
    config.weather_reader = OpenWeatherMapAdapter.new(ENV['WEATHER_SERVICE_CITY_URL'],
                                                      ENV['WEATHER_SERVICE_WEATHER_URL'],
                                                      ENV['WEATHER_SERVICE_API_KEY'])
  end
end
