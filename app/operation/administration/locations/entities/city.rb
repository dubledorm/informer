# frozen_string_literal: true

module Administration
  module Locations
    module Entities
      # Класс, содержащий данные о городе
      class City
        include ActiveModel::Model

        attr_accessor :name, :local_names, :lat, :lon, :country, :state

        def self.columns
          %i[name local_name lat lon country state]
        end

        def attributes
          { 'name' => @name,
            'local_names' => @local_names,
            'lat' => @lat,
            'lon' => @lon,
            'country' => @country,
            'state' => @state,
          }
        end
      end
    end
  end
end
