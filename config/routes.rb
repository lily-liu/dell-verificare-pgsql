Rails.application.routes.draw do

  # ask for jwt token from web server
  post "login", to: "user_token#create", defaults: {format: :json}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # route for absences
  post "absences/create", to: "absences#create", defaults: {format: :json}

  # route for sellout
  post "sellouts/create", to: "sellouts#create", defaults: {format: :json}

  # route for inventory
  post "inventories/create", to: "inventories#create", defaults: {format: :json}

  # route For product knowledge
  get "product_knowledges/list", to: "product_knowledges#index", defaults: {format: :json}
  get "product_knowledges/:id", to: "product_knowledges#show", defaults: {format: :json}
  post "product_knowledges/create", to: "product_knowledges#create", defaults: {format: :json}

  # Route issues
  get "issues/list", to: "issues#index", defaults: {format: :json}
  get "issues/:id", to: "issues#show", defaults: {format: :json}
  post "issues/create", to: "issues#create", defaults: {format: :json}

  # route for posms
  get "posms/inventory/list", to: "posm_store_inventories#index", defaults: {format: :json}
  get "posms/list", to: "posms#index", defaults: {format: :json}
  post "posms/inventory/create", to: "posm_store_inventories#create", defaults: {format: :json}
  post "posms/create", to: "posms#create", defaults: {format: :json}

  # Route Posts
  get "posts/list", to: "posts#index", defaults: {format: :json}
  get "posts/:id", to: "posts#show", defaults: {format: :json}
  post "posts/create", to: "posts#create_post", defaults: {format: :json}
  post "posts/create_comment/:parent_id", to: "posts#create_comment", defaults: {format: :json}

  # routes for stores
  get "stores/list", to: "stores#list_stores", defaults: {format: :json}
  get "dealers/list", to: "stores#list_dealers", defaults: {format: :json}
  get "distributors/list", to: "stores#list_distributors", defaults: {format: :json}
  patch "stores/update/:id", to: "stores#update", defaults: {format: :json}
  post "stores/create", to: "stores#create", defaults: {format: :json}
  delete "stores/delete/:id", to: "stores#destroy", defaults: {format: :json}

  # routes for users
  get "users/list", to: "users#index", defaults: {format: :json}

end
