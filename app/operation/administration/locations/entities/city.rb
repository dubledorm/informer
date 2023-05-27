# frozen_string_literal: true

require 'translit'

module Administration
  module Locations
    module Entities
      # Класс, содержащий данные о городе
      class City
        include ActiveModel::Model

        attr_accessor :name, :local_names, :lat, :lon, :country, :state

        def self.columns
          %i[name russian_name lat lon country state]
        end

        def attributes
          { 'name' => @name,
            'local_names' => @local_names,
            'lat' => @lat,
            'lon' => @lon,
            'country' => @country,
            'state' => @state,
            'russian_name' => russian_name }
        end

        def russian_name
          @russian_name ||= normalize_name(local_names&.dig('ru'))
        end

        private

        def normalize_name(city_name)
          return Translit.convert(@name || '', :english) if city_name.blank?

          city_name
        end
      end
    end
  end
end
