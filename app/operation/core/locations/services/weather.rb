# frozen_string_literal: true

module Core
  module Locations
    module Services
      # Сервис получения данных о погоде
      class Weather
        def self.read(location_id)
          raise 'weather_reader should be defined' unless Operation.weather_reader

          location = Location.find(location_id)
          Operation.weather_reader.weather_read(location.lat, location.lon)
        rescue StandardError => e
          Core::Locations::Dto::WeatherReaderResponse.error(e.message)
        end
      end
    end
  end
end
