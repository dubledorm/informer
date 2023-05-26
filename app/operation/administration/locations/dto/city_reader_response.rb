# frozen_string_literal: true

module Administration
  module Locations
    module Dto
      # Класс, определяющий ответ функций CityReader
      class CityReaderResponse < BaseReaderResponse
        def cities
          @result
        end

        ERROR_MESSAGE = 'Argument cities should be array of Administration::Locations::Entities::City'
        def self.validate!(cities)
          raise ERROR_MESSAGE unless cities.is_a?(Array)

          return if cities.empty?

          raise ERROR_MESSAGE unless cities.first.is_a?(Administration::Locations::Entities::City)
        end
      end
    end
  end
end
