Rails.application.routes.draw do
  devise_for :users,skip: [:passwords,], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
end

scope module: :public do
  root to: 'reservations#index'
  resources :reservations
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
