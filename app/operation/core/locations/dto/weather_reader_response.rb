# frozen_string_literal: true

module Core
  module Locations
    module Dto
      # Класс, определяющий ответ функций WeatherReader
      class WeatherReaderResponse < BaseReaderResponse
        def weather
          @result
        end

        def self.validate!(weather)
          return if weather.is_a?(Core::Locations::Entities::Weather)

          raise 'Weather should be Core::Locations::Entities::Weather'
        end
      end
    end
  end
end
