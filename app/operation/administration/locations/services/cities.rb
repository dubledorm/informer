# frozen_string_literal: true

module Administration
  module Locations
    module Services
      # Сервис получения списка городов по названию
      class Cities
        def self.read(city_name)
          raise 'weather_reader should be defined' unless Operation.weather_reader

          Operation.weather_reader.city_read(city_name, 20)
        rescue StandardError => e
          Administration::Locations::Dto::CityReaderResponse.error(e.message)
        end
      end
    end
  end
end
