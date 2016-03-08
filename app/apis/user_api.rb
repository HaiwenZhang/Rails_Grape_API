class UserAPI < Grape::API
  resources :users do

    params do
      requires :username, type: String
      requires :password, type: String
    end

    post do
      status 200
      user = User.new(username: params[:username], password: params[:password])
      if user.save
        { success: true}
      else
        { errors: user.errors.full_messages }
      end
    end

  end

  resources :user do
    before do
      authenticate_user!
    end

    params do
      requires :user_bio, type: String
      requires :token, type: String
    end

    put do
      if current_user.update(user_bio: params[:user_bio])
        { success: true }
      else
        { errors: current_user.errors.full_message }
      end
    end

  end

end