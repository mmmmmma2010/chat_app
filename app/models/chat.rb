# app/models/chat.rb
class Chat < ApplicationRecord
  belongs_to :application
  has_many :messages, dependent: :destroy

  validates :number, presence: true, uniqueness: { scope: :application_id }
  validates :application_id, presence: true

  before_save :set_default_messages_count

  private

  def set_default_messages_count
    self.messages_count ||= 0
  end
end
