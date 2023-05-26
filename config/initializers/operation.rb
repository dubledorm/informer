require 'operation'
require 'open_weather_map_adapter'

unless Rails.env.test?
  Operation.setup do |config|
    config.weather_reader = OpenWeatherMapAdapter.new('http://api.openweathermap.org/geo/1.0/direct',
                                                      'https://api.openweathermap.org/data/2.5/weather',
                                                      '58938b68bf92fcd0d5002c1b32b15b44')
  end
end