# frozen_string_literal: true

# Запись для сохранения данных о гео местоположениях
class Location < ApplicationRecord
  LOCATION_TYPE_VALUES = %w[city location].freeze
  LAT_LON_FORMAT = /\d+\.\d+/

  validates :russian_name, :lat, :lon, presence: true
  validates :russian_name, uniqueness: true
  validates :location_type, inclusion: { in: LOCATION_TYPE_VALUES }, allow_blank: false
  validates :lat, :lon, format: { with: LAT_LON_FORMAT }
end
