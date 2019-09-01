Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'admin#verifylawyer'
  get 'admin/verifylawyer' => 'admin#verifylawyer'
  resources :job, :name, :state, :phone, :email
  post 'search', to: 'admin#search', as: 'search'
  
end
