# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Administration::Locations::Services::Cities do
  describe 'cities_reader' do
    context 'when weather_reader did not define' do
      before :all do
        Operation.setup do |config|
          config.weather_reader = nil
        end
      end

      it { expect { described_class.read(10) }.to_not raise_exception }
      it { expect(described_class.read(10).is_a?(Administration::Locations::Dto::CityReaderResponse)).to be_truthy }
      it { expect(described_class.read(10).error_code).to eq(:error) }
      it { expect(described_class.read(10).message).to eq('weather_reader should be defined') }
    end

    context 'when weather reader defined' do

      before :all do
        weather_reader_test = WeatherReaderTest.new

        Operation.setup do |config|
          config.weather_reader = weather_reader_test
        end
      end
      it { expect(described_class.read('London').error_code).to eq(:success) }
      it { expect(described_class.read('London').cities.first.name).to eq('London') }
    end
  end
end

class WeatherReaderTest < WeatherReaderBase
  def city_read(city_name, _limit)
    cities = [Administration::Locations::Entities::City.new(name: city_name)]

    Administration::Locations::Dto::CityReaderResponse.success(cities)
  end
end
