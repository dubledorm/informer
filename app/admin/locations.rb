ActiveAdmin.register Location do
  permit_params :name, :russian_name, :lat, :lon, :location_type
  decorate_with LocationDecorator

  form do |f|
    f.inputs do
      if params['mode'] == 'city'
        f.input :name
        f.input :location_type, input_html: { value: :city }, as: :hidden
      else
        f.input :russian_name
        f.input :lat
        f.input :lon
        f.input :location_type, input_html: { value: :location }, as: :hidden
      end
    end
    f.actions
  end


  action_item :new_as_city, only: :index do
    if can? :new_as_city, LocationDecorator
      link_to I18n.t('administration.locations.services.add_city'), new_admin_location_path(mode: :city)
    end
  end

  controller do

    def create
      if params['location']['location_type'] == 'location'
        super
      else
        city_name = params.require('location').require('name')
        response = Administration::Locations::Services::Cities.read(city_name)
        raise StandardError response.message unless response.error_code == :success

        if response.cities.empty?
          @resource = Location.new(name: city_name)
          @resource.errors[:name] << 'Not found'
          render :new
        else
          @cities_collection = response.cities
          render 'select_city_from_list', layout: 'active_admin'
        end
      end
    end
  end
end
