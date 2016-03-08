require 'spec_helper'

describe SessionsAPI, type: :request do

  before :each do
    @user = User.create!(username: 'test', password: '12345678')
  end

  it 'should create the session' do
    post '/api/sessions', username: @user.username, password: @user.password
    response.status.should be == 200
    token = JSON.parse(response.body)['token']
    payload, header = JWT.decode(token, 'key')
    payload['user_id'].should be == @user.id
  end

  it 'should not create the session if wrong password given' do
    post '/api/sessions', username: @user.username, password: '123456'
    response.status.should be == 200
    body = JSON.parse(response.body)
    body['errors'].should_not be_nil
    body['token'].should be_nil
  end
end