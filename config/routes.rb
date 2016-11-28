Rails.application.routes.draw do

  # ask for jwt token from web server
  post "login", to: "user_token#create", defaults: {format: :json}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # route for absences
  post "absences/create", to: "absences#create", defaults: {format: :json}
  get "asd", to: "absences#asd", defaults: {format: :json}

  # route for sellout
  post "sellouts/create", to: "sellouts#create", defaults: {format: :json}
  post "sellouts/ccc", to: "sellouts#ccc", defaults: {format: :json}

  # route for inventory
  post "inventories/create", to: "inventories#create", defaults: {format: :json}

  # route For product knowledge
  get "product_knowledges", to: "product_knowledges#index", defaults: {format: :json}
  get "product_knowledges/:id", to: "product_knowledges#show", defaults: {format: :json}
  post "product_knowledges/create", to: "product_knowledges#create", defaults: {format: :json}

  # Route issues
  get "issues/:id", to: "issues#show", defaults: {format: :json}
  post "issues/create", to: "issues#create", defaults: {format: :json}

  # route for posms
  post "posms/create", to: "posms#create", defaults: {format: :json}
  post "posms/inventory/create", to: "posm_store_inventories#create", defaults: {format: :json}
  get "posms/list", to: "posms#index", defaults: {format: :json}


end
