# frozen_string_literal: true

# Базовый класс для написания адаптеров к погодным сервичам
class WeatherReaderBase
  def weather_read(_lat, _lon)
    Core::Locations::Dto::WeatherReaderResponse.error('Not implemented method WeatherReaderBase.weather_read')
  end

  def city_read(_city_name, _limit)
    Administration::Locations::Dto::CityReaderResponse.error('Not implemented method WeatherReaderBase.city_read')
  end
end
