Rails.application.routes.draw do

  # ask for jwt token from web server
  post 'login' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #Route for absences
  post 'absences' => 'absences#create'

  #Route For Product Knowledge
  get 'product_knowledges' => 'product_knowledges#index'
  post 'product_knowledges' => 'product_knowledges#create'
  get 'product_knowledges/:id' => 'product_knowledges#show'
  get 'product_knowledge/:file_name' => 'product_knowledges#download_file' 

end
