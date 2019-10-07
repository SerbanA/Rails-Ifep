Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'admin#verifylawyer' 
  get 'admin/verifylawyer' => 'admin#verifylawyers'
  post 'search', to: 'admin#search', as: 'admin/search'
  post 'validate_lawyer', to: 'admin#validate_lawyer', as: 'admin/validate_lawyer'
 
end
