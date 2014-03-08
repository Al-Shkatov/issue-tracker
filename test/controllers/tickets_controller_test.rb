require 'test_helper'

class TicketsControllerTest < ActionController::TestCase
  test "should get add" do
    get :add
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get comment" do
    get :comment
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

  test "should get change_status" do
    get :change_status
    assert_response :success
  end

end
