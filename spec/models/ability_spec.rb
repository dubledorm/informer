# frozen_string_literal: true

require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability do
  subject(:ability) { Ability.new(user) }
  let(:user) { nil }

  describe User do

    context 'when user is not authorise' do
      it { expect(ability).to_not be_able_to(:read, User) }
      it { expect(ability).to_not be_able_to(:read, Location) }
      it { expect(ability).to_not be_able_to(:read, LocationDecorator) }
      it { expect(ability).to_not be_able_to(:read, User) }
      it { expect(ability).to_not be_able_to(:to_admin, User) }
    end

    context 'when user is a admin' do
      let(:user) { FactoryBot.create :user_admin }

      it { expect(ability).to_not be_able_to(:manage, User) }
      it { expect(ability).to be_able_to(:read, User) }
      it { expect(ability).to be_able_to(:to_admin, User) }
      it { expect(ability).to be_able_to(:to_user, User) }
      it { expect(ability).to be_able_to(:manage, Location) }
      it { expect(ability).to be_able_to(:manage, LocationDecorator) }
    end

    context 'when user is an ordinal user' do
      let(:user) { FactoryBot.create :user }

      it { expect(ability).to_not be_able_to(:manage, User) }
      it { expect(ability).to_not be_able_to(:read, User) }
      it { expect(ability).to_not be_able_to(:to_admin, User) }
      it { expect(ability).to_not be_able_to(:to_user, User) }
      it { expect(ability).to_not be_able_to(:manage, Location) }
      it { expect(ability).to_not be_able_to(:manage, LocationDecorator) }
      it { expect(ability).to be_able_to(:read, Location) }
      it { expect(ability).to be_able_to(:read, LocationDecorator) }
    end
  end
end
