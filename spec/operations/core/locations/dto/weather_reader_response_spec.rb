# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Core::Locations::Dto::WeatherReaderResponse do
  let(:weather) { Core::Locations::Entities::Weather.new }

  it { expect { described_class.error('some message') }.to_not raise_exception }
  it { expect(described_class.error('some message').is_a?(Core::Locations::Dto::WeatherReaderResponse)).to be_truthy }
  it { expect(described_class.error('some message').error_code).to eq(:error) }
  it { expect(described_class.error('some message').message).to eq('some message') }

  it { expect { described_class.success(nil) }.to raise_error(StandardError) }
  it { expect { described_class.success('some message') }.to raise_error(StandardError) }
  it { expect { described_class.success(weather) }.to_not raise_exception }
  it { expect(described_class.success(weather).is_a?(Core::Locations::Dto::WeatherReaderResponse)).to be_truthy }
  it { expect(described_class.success(weather).error_code).to eq(:success) }
  it { expect(described_class.success(weather).weather.is_a?(Core::Locations::Entities::Weather)).to be_truthy }
end
