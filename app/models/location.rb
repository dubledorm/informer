# frozen_string_literal: true

# Запись для сохранения данных о гео местоположениях
class Location < ApplicationRecord
  LOCATION_TYPE_VALUES = %w[city location].freeze
  LAT_LON_FORMAT = /\A-*\d+\.\d+\Z/

  validates :russian_name, :lat, :lon, presence: true
  validates :russian_name, uniqueness: true
  validates :location_type, inclusion: { in: LOCATION_TYPE_VALUES }, allow_blank: false
  validates :lat, format: { with: LAT_LON_FORMAT }
  validates :lon, format: { with: LAT_LON_FORMAT }
end
