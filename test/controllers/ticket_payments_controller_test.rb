require 'test_helper'

class TicketPaymentsControllerTest < ActionController::TestCase
  setup do
    @ticket_payment = ticket_payments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ticket_payments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ticket_payment" do
    assert_difference('TicketPayment.count') do
      post :create, ticket_payment: { amount: @ticket_payment.amount, ticket_id: @ticket_payment.ticket_id }
    end

    assert_redirected_to ticket_payment_path(assigns(:ticket_payment))
  end

  test "should show ticket_payment" do
    get :show, id: @ticket_payment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ticket_payment
    assert_response :success
  end

  test "should update ticket_payment" do
    patch :update, id: @ticket_payment, ticket_payment: { amount: @ticket_payment.amount, ticket_id: @ticket_payment.ticket_id }
    assert_redirected_to ticket_payment_path(assigns(:ticket_payment))
  end

  test "should destroy ticket_payment" do
    assert_difference('TicketPayment.count', -1) do
      delete :destroy, id: @ticket_payment
    end

    assert_redirected_to ticket_payments_path
  end
end
