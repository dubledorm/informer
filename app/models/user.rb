# frozen_string_literal: true

# Запись для сохранения данных о пользователе
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable, :registerable

  attribute :admin, :boolean, default: false
  validates :admin, inclusion: { in: [true, false] }

  scope :another_admin_exists?, ->(user_id) { where(admin: true).where('id <> ?', user_id).any? }
end
