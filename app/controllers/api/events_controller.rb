class API::EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_access_control_headers

  def create
    registered_application = RegisteredApplication.find_by(url: request.env['HTTP_ORIGIN'])
    render json: "Unregistered application", status: :unprocessable_entity unless registered_application.present?
    if registered_application.present?
      @event = registered_application.events.create(event_params)
      @event.registered_application = registered_application

      if @event.save
        render json: @event, status: :created
      else
        render @event.errors, status: 500
      end
    end
  end

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Content-Type'
  end

  private 

  def event_params
    params.permit(:name)
  end
end
