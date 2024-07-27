# app/controllers/chats_controller.rb
class ChatsController < ApplicationController
  before_action :set_application, only: [:index, :create]

  def index
    @chats = @application.chats
    render json: @chats
  end

  def create
    @chat = @application.chats.build(chat_params)
    @chat.number = @application.chats.maximum(:number).to_i + 1

    if @chat.save
      @application.update(chats_count: @application.chats.count)
      render json: @chat, status: :created
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  private

  def set_application
    @application = Application.find_by!(token: params[:application_id])
  end

  def chat_params
    params.require(:chat).permit(:name)
  end
end
