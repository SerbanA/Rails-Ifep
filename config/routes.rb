Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get  "/search/form" => 'admin#search_page'

  get  "/search" => 'admin#search_results'
  get  "/lawyers/:UUID/:search_value" => 'admin#search_results', as: 'admin_search_results'
  post "api/lawyer/:search_value/:UUID/verify/" => "admin#validate_lawyer", as: 'admin_validate_lawyer'

end
