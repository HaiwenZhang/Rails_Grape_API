class SessionsAPI < Grape::API
  resources :sessions do
    params do
      requires :username, type: String
      requires :password, type: String
    end

    post do
      status 200
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        { token: JWT.encode({user_id: user.id}, 'key')}
      else
        { errors: "Wrong username or password"}
      end
    end

  end
end