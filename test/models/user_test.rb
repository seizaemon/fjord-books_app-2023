# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = create(:user)
  end

  test 'name_or_emailメソッドでnameの登録がある場合はnameが返る' do
    @user.name = 'test user'
    assert_equal 'test user', @user.name_or_email
  end

  test 'name_or_emailメソッドでnameが無い場合はemailが返る' do
    assert_equal @user.email, @user.name_or_email
  end
end
