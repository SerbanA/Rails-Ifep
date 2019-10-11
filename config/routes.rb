Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'admin#search_page' 
  get  "api/search/:search_value/:uuid" => 'admin#search_results', as: 'admin_search_results'
  post "api/lawyer/:search_value/:uuid/verify/" => "admin#validate_lawyer", as: 'admin_validate_lawyer'

end
