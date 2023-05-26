# frozen_string_literal: true

module Administration
  module Users
    module Services
      # Класс, снимающий у пользователя признак Администратор
      class ToUser
        def self.call!(user)
          ActiveRecord::Base.transaction(isolation: :repeatable_read) do
            raise StandardError I18n.t('administration.users.errors.last_admin') unless User.another_admin_exists?(user)

            user.admin = false
            user.save!
          end
        end
      end
    end
  end
end
