# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Core::Locations::Services::Weather do
  describe 'weather_reader' do
    context 'when weather reader did not define' do
      before :all do
        Operation.setup do |config|
          config.weather_reader = nil
        end
      end

      it { expect { described_class.read(10) }.to_not raise_exception }
      it { expect(described_class.read(10).is_a?(Core::Locations::Dto::WeatherReaderResponse)).to be_truthy }
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

      it { expect { described_class.read(10) }.to_not raise_exception }
      it { expect(described_class.read(10).is_a?(Core::Locations::Dto::WeatherReaderResponse)).to be_truthy }
      it { expect(described_class.read(10).error_code).to eq(:error) }
      it { expect(described_class.read(10).message).to eq('Couldn\'t find Location with \'id\'=10') }
    end
  end

  describe 'read' do
    let!(:location) { FactoryBot.create :location }

    it { expect(described_class.read(location.id).error_code).to eq(:success) }
    it { expect(described_class.read(location.id).weather.lat).to eq(location.lat) }
    it { expect(described_class.read(location.id).weather.lon).to eq(location.lon) }
    it { expect(described_class.read(location.id).weather.temp).to eq(126) }

    it { expect(described_class.read(location.id + 1).error_code).to eq(:error) }
  end
end

class WeatherReaderTest < WeatherReaderBase
  def weather_read(lat, lon)
    weather = Core::Locations::Entities::Weather.new(lat:, lon:, temp: 126)

    Core::Locations::Dto::WeatherReaderResponse.success(weather)
  end
end
