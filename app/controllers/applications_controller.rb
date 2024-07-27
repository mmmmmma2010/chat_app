# app/controllers/applications_controller.rb
class ApplicationsController < ApplicationController
  def create
    @application = Application.new(application_params)
    @application.token = SecureRandom.hex(10) # Generate a unique token

    if @application.save
      render json: @application, status: :created
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  def show
    @application = Application.find_by!(token: params[:id])
    render json: @application
  end

  def update
    @application = Application.find_by!(token: params[:id])
    if @application.update(application_params)
      render json: @application
    else
      render json: @application.errors, status: :unprocessable_entity
    end
  end

  private

  def application_params
    params.require(:application).permit(:name)
  end
end
