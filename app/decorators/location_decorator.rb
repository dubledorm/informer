# frozen_string_literal: true

# Декоратор для Location
class LocationDecorator < Draper::Decorator
  delegate_all

  DEFAULT_LOCATION_TYPE = 'undefined'

  def location_type
    I18n.t("activerecord.values.location.location_type.#{object.location_type || DEFAULT_LOCATION_TYPE}")
  end

  def title
    russian_name
  end
end
