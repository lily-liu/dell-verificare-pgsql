Rails.application.routes.draw do

  # ask for jwt token from web server
  post "login", to: "user_token#create", defaults: {format: :json}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # route for absences
  post "absences/create", to: "absences#create", defaults: {format: :json}

  # route for sellout
  post "sellouts/create", to: "sellouts#create", defaults: {format: :json}
  get "sellouts/list", to: "sellouts#index", defaults: {format: :json}
  get "sellouts/recap_cam", to: "sellouts#sellouts_per_cam", defaults: {format: :json}

  # route for inventory
  post "inventories/create", to: "inventories#create", defaults: {format: :json}
  get "inventories/list", to: "inventories#index", defaults: {format: :json}
  get "inventories/recap_cam", to: "inventories#inventories_per_cam", defaults: {format: :json}


  # route For product knowledge
  get "sell_kits/list", to: "sell_kits#index", defaults: {format: :json}
  get "sell_kits/:id", to: "sell_kits#show", defaults: {format: :json}
  post "sell_kits/create", to: "sell_kits#create", defaults: {format: :json}

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
  post "users/create", to: "users#create", defaults: {format: :json}
  patch "users/update/:id", to: "users#update", defaults: {format: :json}
  delete "users/delete/:id", to: "users#destroy", defaults: {format: :json}

  # routes for Sellin
  get "sellins/list", to: "sellins#index", defaults: {format: :json}
  patch "sellins/update/:id", to: "sellins#update", defaults: {format: :json}
  post "sellins/import", to: "sellins#input_sellin_from_csv", defaults: {format: :json}
  get "sellins/export", to: "sellins#sellin_csv_export", defaults: {format: :csv}

  # route for cities
  get "cities/list", to: "cities#index", defaults: {format: :json}
  post "cities/create", to: "cities#create", defaults: {format: :json}

  # route for region
  get "regions/list", to: "regions#index", defaults: {format: :json}

  # route for visibility
  get "visibilities/list_per_user_store", to: "visibilities#list_visibility_per_user_and_store", defaults: {format: :json}
  post "visibilities/create", to: "visibilities#create", defaults: {format: :json}
  get "visibilities/list_view", to: "visibilities#list_visibility_view"

  # route for conflicted items
  get "conflicts/inventories", to: "conflicted_items#list_conflicted_inventory", defaults: {format: :json}
  get "conflicts/sellouts", to: "conflicted_items#list_conflicted_sellouts", defaults: {format: :json}



end
