# frozen_string_literal: true

module Core
  module Locations
    module Entities
      # Класс, содержащий данные о погоде
      class Weather
        include ActiveModel::Model

        attr_accessor :temp, :temp_feels_like, :temp_min, :temp_max, :pressure, :lat, :lon,
                      :wind_speed, :wind_deg, :wind_gust

        def self.columns
          %i[temp temp_feels_like temp_min temp_max pressure lat lon wind_speed wind_deg wind_gust]
        end

        def attributes
          { 'temp' => @temp,
            'temp_feels_like' => @temp_feels_like,
            'temp_min' => @temp_min,
            'temp_max' => @temp_max,
            'pressure' => @pressure,
            'lat' => @lat,
            'lon' => @lon,
            'wind_speed' => @wind_speed,
            'wind_deg' => @wind_deg,
            'wind_gust' => @wind_gust }
        end
      end
    end
  end
end
