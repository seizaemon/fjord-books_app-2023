# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @test_user = User.new
    @test_user.email = 'test@test.com'
  end

  test 'name_or_emailメソッドでnameの登録がある場合はnameが返る' do
    @test_user.name = 'test user'
    assert_equal 'test user', @test_user.name_or_email
  end

  test 'name_or_emailメソッドでnameが無い場合はemailが返る' do
    assert_equal 'test@test.com', @test_user.name_or_email
  end
end
