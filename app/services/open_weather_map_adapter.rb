# frozen_string_literal: true
require 'weather_reader_base'

# Реализация WeatherReader для доступа к сервису OpenWeatherMap
class OpenWeatherMapAdapter < WeatherReaderBase

  def initialize(geo_coding_url, weather_url, api_key)
    super()
    @geo_coding_uri = URI.parse(geo_coding_url)
    @weather_uri = URI.parse(weather_url)
    @api_key = api_key
  end

  def weather_read(lat, lon)
    params = { lat:, lon:, appid: @api_key, lang: 'ru', units: 'metric' }
    @weather_uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get_response(@weather_uri)
    return error_response(response) unless response.is_a?(Net::HTTPSuccess)

    weather = weather_from_body(response.body)
    Core::Locations::Dto::WeatherReaderResponse.success(weather)
  end

  def city_read(city_name, limit)
    params = { q: city_name, limit:, appid: @api_key }
    @geo_coding_uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get_response(@geo_coding_uri)
    return error_response(response) unless response.is_a?(Net::HTTPSuccess)

    cities = cities_from_body(response.body)
    Administration::Locations::Dto::CityReaderResponse.success(cities)
  end

  private

  WEATHER_MAPPING = { lat: 'coord/lat',
                      lon: 'coord/lon',
                      temp: 'main/temp',
                      temp_feels_like: 'main/feels_like',
                      temp_min: 'main/temp_min',
                      temp_max: 'main/temp_max',
                      pressure: 'main/pressure',
                      wind_speed: 'wind/speed',
                      wind_deg: 'wind/deg',
                      wind_gust: 'wind/gust' }.freeze

  def weather_from_body(body)
    data = JSON.parse(body)
    weather = data_mapping(WEATHER_MAPPING, data)
    Core::Locations::Entities::Weather.new(weather)
  end

  CITY_MAPPING = { name: 'name',
                   local_names: 'local_names',
                   lat: 'lat',
                   lon: 'lon',
                   country: 'country',
                   state: 'state' }.freeze

  def cities_from_body(body)
    data = JSON.parse(body)
    data.map { |city| Administration::Locations::Entities::City.new(data_mapping(CITY_MAPPING, city)) }
  end

  def data_mapping(map, data)
    Hash[*(map.map { |key, value| [key, data.dig(*value.split('/'))] }).flatten]
  end

  def error_response(http_res)
    Core::Locations::Dto::WeatherReaderResponse.error("Error. Kod: #{http_res.code}, #{http_res.message}," \
" url: #{http_res.uri}")
  end
end
