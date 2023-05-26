# frozen_string_literal: true

module Administration
  module Users
    module Services
      # Класс устанавливающий у пользователя признак Администратор
      class ToAdmin
        def self.call!(user)
          user.admin = true
          user.save!
        end
      end
    end
  end
end
