Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'admin#verifylawyer' 
  get 'admin/verifylawyer' => 'admin#verifylawyers'
  post 'search', to: 'admin#search', as: 'admin/search'
  post 'validation', to: 'admin#validation', as: 'admin/validation'

  resources :job, :name, :state, :phone, :email
 

end
