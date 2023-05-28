# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.main_page') }

  content title: proc { I18n.t('active_admin.site_title') } do
    div class: 'blank_slate_container', id: 'dashboard_default_message' do
      span class: 'blank_slate' do
        span I18n.t('active_admin.welcome_message')
        para do
          small I18n.t('active_admin.description')
          small link_to('https://openweathermap.org/', 'https://openweathermap.org/')
         end
      end
    end
  end # content
end
