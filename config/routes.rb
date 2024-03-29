Rails.application.routes.draw do

  # ask for jwt token from web server
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "login", to: "user_token#create", defaults: {format: :json}

  # route for absences
  get "absences/list", to: "absences#index", defaults: {format: :json}
  get "absences/list_self", to: "absences#index_non_admin", defaults: {format: :json}
  get "absences/export", to: "absences#export_absence", defaults: {format: :csv}
  post "absences/create", to: "absences#create", defaults: {format: :json}

  # route for sellout
  get "sellouts/list", to: "sellouts#index", defaults: {format: :json}
  get "sellouts/list_per_user", to: "sellouts#index_per_user", defaults: {format: :json}
  get "sellouts/recap_cam", to: "sellouts#sellouts_per_cam", defaults: {format: :json}
  get "sellouts/recap_cam_monthly", to: "sellouts#sellouts_per_cam_monthly", defaults: {format: :json}
  get "sellouts/recap_store_cam", to: "sellouts#sellouts_each_cam_per_store", defaults: {format: :json}
  get "sellouts/recap_sku", to: "sellouts#sellouts_per_sku", defaults: {format: :json}
  get "sellouts/recap_sku_price_category", to: "sellouts#sellouts_sku_per_price_category", defaults: {format: :json}
  get "sellouts/recap_sku_best10", to: "sellouts#sellouts_per_sku_best10", defaults: {format: :json}
  get "sellouts/recap_sku_worst10", to: "sellouts#sellouts_per_sku_worst10", defaults: {format: :json}
  get "sellouts/recap_region", to: "sellouts#sellouts_per_region", defaults: {format: :json}
  get "sellouts/recap_region_monthly", to: "sellouts#sellouts_per_region_monthly", defaults: {format: :json}
  get "sellouts/recap_region_store", to: "sellouts#sellouts_each_store_per_region", defaults: {format: :json}
  get "sellouts/recap_sku_cam", to: "sellouts#sellout_each_sku_per_cam", defaults: {format: :json}
  get "sellouts/recap_sku_region", to: "sellouts#sellout_each_sku_per_region", defaults: {format: :json}
  get "sellouts/export_report", to: "sellouts#sellout_report_export_csv", defaults: {format: :csv}
  get "sellouts/export", to: "sellouts#export_sellout", defaults: {format: :csv}
  get "sellouts/search", to: "sellouts#search_service_tag", defaults: {format: :json}
  get "sellouts/bulk_search", to: "sellouts#bulk_search_service_tag", defaults: {format: :json}
  get "sellouts/:id", to: "sellouts#show", defaults: {format: :json}
  post "sellouts/create", to: "sellouts#create", defaults: {format: :json}
  post "sellouts/import", to: "sellouts#import_sellout", defaults: {format: :json}
  patch "sellouts/update/:id", to: "sellouts#update", defaults: {format: :json}

  # route for inventory
  get "inventories/list", to: "inventories#index", defaults: {format: :json}
  get "inventories/list_per_user", to: "inventories#index_per_user", defaults: {format: :json}
  get "inventories/recap_cam", to: "inventories#inventories_per_cam", defaults: {format: :json}
  get "inventories/recap_store_cam", to: "inventories#inventories_each_cam_per_store", defaults: {format: :json}
  get "inventories/export_list", to: "inventories#inventories_export", defaults: {format: :json}
  get "inventories/search", to: "inventories#search_service_tag", defaults: {format: :json}
  get "inventories/bulk_search", to: "inventories#bulk_search_service_tag", defaults: {format: :json}
  post "inventories/create", to: "inventories#create", defaults: {format: :json}
  post "inventories/import", to: "inventories#import_inventory", defaults: {format: :json}

  # route For product knowledge
  get "sell_kits/list", to: "sell_kits#show_fltered_list", defaults: {format: :json}
  get "sell_kits/list_dashboard", to: "sell_kits#index", defaults: {format: :json}
  get "sell_kits/download/:id", to: "sell_kits#download_data", defaults: {format: :json}
  get "sell_kits/:id", to: "sell_kits#show", defaults: {format: :json}
  post "sell_kits/create", to: "sell_kits#create", defaults: {format: :json}

  # Route issues
  get "issues/list", to: "issues#index", defaults: {format: :json}
  get "issues/:id", to: "issues#show", defaults: {format: :json}
  post "issues/create", to: "issues#create", defaults: {format: :json}

  # route for posms
  get "posms/inventory/list", to: "posm_store_inventories#index", defaults: {format: :json}
  get "posms/list", to: "posms#index", defaults: {format: :json}
  get "posms/recap_category", to: "posms#posm_per_category", defaults: {format: :json}
  get "posms/list_category", to: "posms#list_user_levels", defaults: {format: :json}
  get "posms/inventory/list", to: "posm_store_inventories#index", defaults: {format: :json}
  get "posms/inventory/export", to: "posm_store_inventories#posm_inventory_csv_export", defaults: {format: :json}
  get "posms/:id", to: "posms#show", defaults: {format: :json}
  post "posms/inventory/create", to: "posm_store_inventories#create", defaults: {format: :json}
  post "posms/create", to: "posms#create", defaults: {format: :json}
  patch "posms/update/:id", to: "posms#update", defaults: {format: :json}

  # Route Posts
  get "posts/list", to: "posts#index", defaults: {format: :json}
  get "posts/list_comments/:post_id", to: "posts#list_comments", defaults: {format: :json}
  get "posts/notif", to: "posts#push_notif", defaults: {format: :json}
  get "posts/:id", to: "posts#show", defaults: {format: :json}
  post "posts/create", to: "posts#create_post", defaults: {format: :json}
  post "posts/create_comment/:parent_id", to: "posts#create_comment", defaults: {format: :json}

  # routes for stores
  get "stores/list", to: "stores#list_stores", defaults: {format: :json}
  get "dealers/list", to: "stores#list_dealers", defaults: {format: :json}
  get "distributors/list", to: "stores#list_distributors", defaults: {format: :json}
  get "stores/export", to: "stores#stores_csv_export", defaults: {format: :csv}
  get "stores/list_level", to: "stores#list_store_levels", defaults: {format: :json}
  get "stores/list_category", to: "stores#list_store_categories", defaults: {format: :json}
  get "stores/:id", to: "stores#show", defaults: {format: :json}
  patch "stores/update/:id", to: "stores#update", defaults: {format: :json}
  post "stores/create", to: "stores#create", defaults: {format: :json}
  post "stores/import", to: "stores#import_store", defaults: {format: :json}
  delete "stores/delete/:id", to: "stores#destroy", defaults: {format: :json}


  # routes for users
  get "users/list", to: "users#index", defaults: {format: :json}
  get "users/list_level", to: "users#list_user_levels", defaults: {format: :json}
  get "users/list_gender", to: "users#list_user_genders", defaults: {format: :json}
  get "users/export", to: "users#users_csv_export", defaults: {format: :json}
  get "users/:id", to: "users#show", defaults: {format: :json}
  post "users/create", to: "users#create", defaults: {format: :json}
  post "users/import", to: "users#import_user", defaults: {format: :json}
  patch "users/update/:id", to: "users#update", defaults: {format: :json}
  delete "users/delete/:id", to: "users#destroy", defaults: {format: :json}

  # routes for managers
  get "managers/list", to: "managers#index", defaults: {format: :json}
  get "managers/export", to: "managers#managers_csv_export", defaults: {format: :json}
  get "managers/:id", to: "managers#show", defaults: {format: :json}
  post "managers/create", to: "managers#create", defaults: {format: :json}
  patch "managers/update/:id", to: "managers#update", defaults: {format: :json}
  delete "managers/delete/:id", to: "managers#destroy", defaults: {format: :json}

  # routes for Sellin
  get "sellins/list", to: "sellins#index", defaults: {format: :json}
  get "sellins/export", to: "sellins#sellin_csv_export"
  get "sellins/search", to: "sellins#search_service_tag", defaults: {format: :json}
  get "sellins/bulk_search", to: "sellins#bulk_search_service_tag", defaults: {format: :json}
  get "sellins/:id", to: "sellins#show", defaults: {format: :json}
  post "sellins/import", to: "sellins#input_sellin_from_csv", defaults: {format: :json}
  patch "sellins/update/:id", to: "sellins#update", defaults: {format: :json}

  # route for cities
  get "cities/list", to: "cities#index", defaults: {format: :json}
  get "cities/export", to: "cities#cities_csv_export"
  get "cities/:id", to: "cities#show", defaults: {format: :json}
  post "cities/create", to: "cities#create", defaults: {format: :json}
  post "cities/import", to: "cities#import_city", defaults: {format: :json}


  # route for region
  get "regions/list", to: "regions#index", defaults: {format: :json}
  get "regions/export", to: "regions#regions_csv_export"


  # route for visibility
  get "visibilities/list", to: "visibilities#index", defaults: {format: :json}
  get "visibilities/list_per_user_store", to: "visibilities#list_visibility_per_user_and_store", defaults: {format: :json}
  get "visibilities/recap_per_user_store", to: "visibilities#export_zip"
  post "visibilities/create", to: "visibilities#create", defaults: {format: :json}

  # route for conflicted items
  get "conflicts/inventories", to: "conflicted_items#list_conflicted_inventory", defaults: {format: :json}
  get "conflicts/sellouts", to: "conflicted_items#list_conflicted_sellouts", defaults: {format: :json}


end
