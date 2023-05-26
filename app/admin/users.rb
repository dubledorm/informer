ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :admin
    column :created_at
    actions
  end

  filter :email
  filter :admin
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  member_action :to_admin, method: :post do
    Administration::Users::Services::ToAdmin.call!(resource)
    redirect_to admin_user_path(id: resource.id)
  end

  action_item :to_admin, only: :show do
    if can? :to_admin, resource
      link_to I18n.t('administration.users.services.to_admin'), to_admin_admin_user_path(id: resource.id), method: :post
    end
  end

  member_action :to_user, method: :post do
    Administration::Users::Services::ToUser.call!(resource)
    redirect_to admin_user_path(id: resource.id)
  end

  action_item :to_user, only: :show do
    if can? :to_user, resource
      link_to I18n.t('administration.users.services.to_user'), to_user_admin_user_path(id: resource.id), method: :post
    end
  end
end
