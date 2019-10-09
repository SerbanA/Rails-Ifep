Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'admin#verifylawyer' 
  post 'search', to: 'admin#search'

  resources :uuid

post "/api/UUID/:uuid/verify/" => "admin#validate_lawyer", as: 'admin_validate_lawyer'

end
