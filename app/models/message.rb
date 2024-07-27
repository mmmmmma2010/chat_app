# app/models/message.rb
class Message < ApplicationRecord
  belongs_to :chat

  validates :number, presence: true, uniqueness: { scope: :chat_id }
  validates :chat_id, presence: true
  validates :body, presence: true

  searchkick

  def search_data
    {
      body: body
    }
  end
end
