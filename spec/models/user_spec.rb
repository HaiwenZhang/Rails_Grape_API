require 'spec_helper'

describe User do
  it "Should valiate password" do
    user = User.create(username: 'test', password: 'right')
    user.authenticate('right').should be_true
    user.authenticate('falsjfal').should be_false
  end
end