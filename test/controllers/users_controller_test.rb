# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should get index' do
    sign_in users(:one)
    get users_url
    assert_response :success
  end

  test 'should get show' do
    sign_in users(:one)
    get user_url users(:one).id
    assert_response :success
  end
end
