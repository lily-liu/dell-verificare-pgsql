Rails.application.routes.draw do

  # ask for jwt token from web server
  post 'login' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #Route for absences
  post 'absences' => 'absences#create'

end
