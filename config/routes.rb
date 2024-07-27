# config/routes.rb
Rails.application.routes.draw do
  resources :applications, only: [:create, :show, :update] do
    resources :chats, only: [:index]
  end

  resources :chats, only: [] do
    resources :messages, only: [:create, :index]
  end

  get 'chats/:chat_id/messages/search', to: 'messages#search', as: :search_messages
end
