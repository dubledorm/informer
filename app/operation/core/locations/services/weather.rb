# frozen_string_literal: true

module Core
  module Locations
    module Services
      # Сервис получения данных о погоде
      class Weather
        def self.read(location_id)
          raise 'weather_reader should be defined' unless Operation.weather_reader

          location = Location.find(location_id)
          response = Rails.cache.fetch("weather_response_#{location.lat}_#{location.lon}", expires_in: 3.hours) do
            Operation.weather_reader.weather_read(location.lat, location.lon)
          end
          Rails.cache.delete("weather_response_#{location.lat}_#{location.lon}") unless response.success?

          response
        rescue StandardError => e
          Core::Locations::Dto::WeatherReaderResponse.error(e.message)
        end
      end
    end
  end
end
