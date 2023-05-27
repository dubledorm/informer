ActiveAdmin.register Location do
  permit_params :name, :russian_name, :lat, :lon, :location_type
  decorate_with LocationDecorator

  form do |f|
    f.inputs do
      f.input :russian_name
      f.input :lat
      f.input :lon
      f.input :location_type, input_html: { value: :location }, as: :hidden
      f.input :name, input_html: { value: :name }, as: :hidden
    end
    f.actions
  end

  show title: :russian_name do
    attributes_table do
      row :name
      row :russian_name
      row :location_type
      row :lat
      row :lon
      row :created_at
      row :updated_at
    end

    render 'weather'
    active_admin_comments
  end

  action_item :new_as_city, only: :index do
    if can? :new_as_city, LocationDecorator
      link_to I18n.t('administration.locations.services.add_city'), new_as_city_admin_locations_path
    end
  end

  collection_action :new_as_city do
    redirect_to admin_locations_path, alert: I18n.t('active_admin.not_authorized') unless can? :new_as_city, Location

    @resource = Location.new
  end

  collection_action :create_as_city, method: :post do
    redirect_to admin_locations_path, alert: I18n.t('active_admin.not_authorized') unless can? :create_as_city, Location

    city_name = params.require('location').require('name')
    response = Administration::Locations::Services::Cities.read(city_name)
    raise StandardError, response.message unless response.error_code == :success

    if response.cities.empty?
      @resource = Location.new(name: city_name)
      @resource.errors.add :name, :not_found, message: I18n.t('administration.locations.errors.not_found')
      render :new_as_city
    else
      @cities_collection = response.cities
      render 'select_city_from_list', layout: 'active_admin'
    end
  end

  controller do

    def show
      super do
        response = Core::Locations::Services::Weather.read(resource.id)
        raise StandardError, response.message unless response.error_code == :success

        @weather = response.weather
      end
    end
  end
end
