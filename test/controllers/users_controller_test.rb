require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    Kredis.redis.flushall
    @user = users(:one)
  end

  test 'should not rate limit normal use' do
    49.times do
      get users_url
      assert_response :success
    end
  end

  test 'should rate limit abnormal use' do
    50.times do
      get users_url
      assert_response :success
    end

    get users_url
    assert_response :too_many_requests
  end
end
