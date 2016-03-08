class NoteAPI < Grape::API
  format :json

  helpers do

    def authenticate_user!
      begin
        payload,  = JWT.decode(params[:token], 'key')
        @current_user = User.find(payload['user_id'])
      rescue StandardError
      end
      error!({errors: "unauthented access"}, 401) if @current_user.nil?
    end

    def current_user
      @current_user
    end

  end

  mount UserAPI
  mount SessionsAPI
  mount BijiAPI

  add_swagger_documentation base_path: 'api', hide_format: true
end