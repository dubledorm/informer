# frozen_string_literal: true

# Декоратор для Location
class LocationDecorator < Draper::Decorator
  delegate_all

  DEFAULT_LOCATION_TYPE = 'undefined'

  def location_type
    I18n.t("activerecord.values.location.location_type.#{object.location_type || DEFAULT_LOCATION_TYPE}")
  end

  # TODO: Скорее всего не понадобится
  def self.translate_location_types
    Location::LOCATION_TYPE_VALUES.map do |value|
      [I18n.t("activerecord.values.location.location_type.#{value || DEFAULT_LOCATION_TYPE}"), value]
    end
  end
end
