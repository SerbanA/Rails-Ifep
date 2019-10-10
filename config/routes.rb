Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get  "admin/search_page"
  root 'admin#search_page' 

  resources :uuid,:search_value
  
  post "/api/search/UUID/:uuid" => 'admin#search_results',as: 'admin_search_results'
  post "/api/UUID/:uuid/search_value/:search_value" => "admin#validate_lawyer", as: 'admin_validate_lawyer'

end
