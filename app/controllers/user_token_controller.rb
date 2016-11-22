class UserTokenController < Knock::AuthTokenController

  # override permitted params
  def auth_params
    params.require(:auth).permit :username, :password_digest
  end

  # override knock password column on db
  def authenticate
    unless entity.present? && entity.authenticate(auth_params[:password_digest])
      raise Knock.not_found_exception_class
    end
  end

  # override knock entity checking column on db
  def entity
    @entity ||=
        if entity_class.respond_to? :from_token_request
          entity_class.from_token_request request
        else
          entity_class.find_by username: auth_params[:username]
        end
  end

end
