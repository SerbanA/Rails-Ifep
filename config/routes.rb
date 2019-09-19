Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'admin#verifylawyer' 
  get 'admin/verifylawyer' => 'admin#verifylawyers'
  post 'search', to: 'admin#search', as: 'admin/search'

  post 'is_valid', to: 'admin#is_valid', as: 'admin/is_valid'
  post 'not_valid', to: 'admin#not_valid', as: 'admin/not_valid'
  resources :job, :name, :state, :phone, :email
 

end
