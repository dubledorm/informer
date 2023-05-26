# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Administration::Locations::Dto::CityReaderResponse do
  let(:city) { Administration::Locations::Entities::City.new }

  it { expect { described_class.error('some message') }.to_not raise_exception }
  it { expect(described_class.error('some message').is_a?(Administration::Locations::Dto::CityReaderResponse)).to be_truthy }
  it { expect(described_class.error('some message').error_code).to eq(:error) }
  it { expect(described_class.error('some message').message).to eq('some message') }

  it { expect { described_class.success(nil) }.to raise_error(StandardError) }
  it { expect { described_class.success('some message') }.to raise_error(StandardError) }
  it { expect { described_class.success(city) }.to raise_error(StandardError) }
  it { expect { described_class.success([]) }.to_not raise_exception }
  it { expect { described_class.success([city]) }.to_not raise_exception }
  it { expect(described_class.success([city]).is_a?(Administration::Locations::Dto::CityReaderResponse)).to be_truthy }
  it { expect(described_class.success([city]).error_code).to eq(:success) }
  it { expect(described_class.success([city]).cities.is_a?(Array)).to be_truthy }
  it { expect(described_class.success([city]).cities.first.is_a?(Administration::Locations::Entities::City)).to be_truthy }
end
