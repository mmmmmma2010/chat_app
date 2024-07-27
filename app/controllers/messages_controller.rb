# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  before_action :set_chat, only: [:create, :index]

  def index
    @messages = @chat.messages
    render json: @messages
  end

  def create
    @message = @chat.messages.build(message_params)
    @message.number = @chat.messages.maximum(:number).to_i + 1

    if @message.save
      @chat.update(messages_count: @chat.messages.count)
      render json: @message, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  def search
    @messages = Message.search(params[:q], where: { chat_id: params[:chat_id] })
    render json: @messages
  end

  private

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
