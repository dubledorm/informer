# frozen_string_literal: true

# Класс, определяющий права доступа
class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, (ActiveAdmin.register_page 'Dashboard')
    can :read, LocationDecorator
    can :read, Location

    return unless user.present?

    return unless user.admin?

    can :read, User
    can :to_admin, User, admin?: false
    can :to_user, User do |record|
      record.admin? && record.id != user.id
    end

    can :manage, LocationDecorator
    can :manage, Location
  end
end
