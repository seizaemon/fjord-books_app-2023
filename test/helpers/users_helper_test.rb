# frozen_string_literal: true

require 'test_helper'
class UsersHelperTest < ActionView::TestCase
  def setup
    @user = create :user
  end

  test 'current_user_nameでemailのみをセットした場合emailだけ返る' do
    assert_equal current_user_name(@user), @user.email
  end

  test 'current_user_nameでnameとemail両方セットしてあると両方返る' do
    @user.name = 'test user'
    assert_equal current_user_name(@user), @user.name
  end
end
