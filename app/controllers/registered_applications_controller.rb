class RegisteredApplicationsController < ApplicationController
  def index
    @user = current_user
    @registered_applications = @user.registered_applications
  end

  def show
    @registered_application = RegisteredApplication.find(params[:id])
    @events = @registered_application.events.group_by(&:name)
  end

  def new
    @registered_application = RegisteredApplication.new
    
  end

  def edit
    @registered_application = RegisteredApplication.find(params[:id])
  end

  def create
    @user = current_user
    @registered_application = @user.registered_applications.build(application_params)
    @registered_application.user = @user

    if @registered_application.save
      flash[:notice] = "Registered Applicated created successfully."
      redirect_to @registered_application
    else
      flash[:error] = "There was an error. Please try again."
      render :new
    end
  end

  def destroy
    @registered_application = RegisteredApplication.find(params[:id])

    if @registered_application.destroy
      flash[:notice] = "Registered Application deleted."
      render :index
    else
      flash[:error] = "There was an error deleting the application. Please try again."
      render :edit
    end
  end

  def update
    @registered_application = RegisteredApplication.find(params[:id])

    if @registered_application.update_attributes(application_params)
      flash[:notice] = "Application was updated."
      redirect_to @registered_application
    else
      flash[:error] = "There was an error. Please try again."
      render :edit
    end
  end

  private 

  def application_params
    params.require(:registered_application).permit(:name, :url)
  end
end
