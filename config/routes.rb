Rails.application.routes.draw do

  # ask for jwt token from web server
  post "login", to: "user_token#create", defaults:{format: :json}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #Route for absences
  post "absences/create", to:"absences#create", defaults:{format: :json}
  get "asd",  to:"absences#asd", defaults:{format: :json}

end
