require 'test_helper'

class CancelReasonsControllerTest < ActionController::TestCase
  setup do
    @cancel_reason = cancel_reasons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cancel_reasons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cancel_reason" do
    assert_difference('CancelReason.count') do
      post :create, cancel_reason: { text: @cancel_reason.text }
    end

    assert_redirected_to cancel_reason_path(assigns(:cancel_reason))
  end

  test "should show cancel_reason" do
    get :show, id: @cancel_reason
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cancel_reason
    assert_response :success
  end

  test "should update cancel_reason" do
    patch :update, id: @cancel_reason, cancel_reason: { text: @cancel_reason.text }
    assert_redirected_to cancel_reason_path(assigns(:cancel_reason))
  end

  test "should destroy cancel_reason" do
    assert_difference('CancelReason.count', -1) do
      delete :destroy, id: @cancel_reason
    end

    assert_redirected_to cancel_reasons_path
  end
end
