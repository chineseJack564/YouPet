# frozen_string_literal: true

class ApplicationController < ActionController::Base
    rescue_from ActionController::RoutingError, with: :page_not_found
    def page_not_found
        respond_to do |format|
          format.html { render template: 'error/index', layout: 'layouts/application', status: 404 }
          format.all  { render nothing: true, status: 404 }
        end
    end
end
