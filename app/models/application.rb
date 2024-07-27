# app/models/application.rb
class Application < ApplicationRecord
  has_many :chats, dependent: :destroy

  validates :name, presence: true
  validates :token, presence: true, uniqueness: true

  before_save :set_default_chats_count

  private

  def set_default_chats_count
    self.chats_count ||= 0
  end
end
