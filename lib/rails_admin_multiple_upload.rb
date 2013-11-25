require "rails_admin_multiple_upload/engine"

module RailsAdminMultipleUpload
end

require 'rails_admin/config/actions'

module RailsAdmin
  module Config
    module Actions
      class MultipleUpload < Base
        RailsAdmin::Config::Actions.register(self)
        register_instance_option :member do
          true
        end

        register_instance_option :link_icon do
          'icon-upload'
        end

        register_instance_option :http_methods do
          [:get, :post]
        end

        register_instance_option :controller do
          Proc.new do
            @response = {}

            if request.post?
              @album = Album.find_by_id(params[:album_id])
              @album.update_attribute(:photos_attributes, params[:album][:photos_attributes])
            end

            render :action => @action.template_name
          end
        end
      end
    end
  end
end

