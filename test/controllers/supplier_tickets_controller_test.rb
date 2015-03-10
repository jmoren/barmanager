require 'test_helper'

class SupplierTicketsControllerTest < ActionController::TestCase
  setup do
    @supplier_ticket = supplier_tickets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:supplier_tickets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create supplier_ticket" do
    assert_difference('SupplierTicket.count') do
      post :create, supplier_ticket: { amount: @supplier_ticket.amount, shift_id: @supplier_ticket.shift_id, supplier_id: @supplier_ticket.supplier_id }
    end

    assert_redirected_to supplier_ticket_path(assigns(:supplier_ticket))
  end

  test "should show supplier_ticket" do
    get :show, id: @supplier_ticket
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @supplier_ticket
    assert_response :success
  end

  test "should update supplier_ticket" do
    patch :update, id: @supplier_ticket, supplier_ticket: { amount: @supplier_ticket.amount, shift_id: @supplier_ticket.shift_id, supplier_id: @supplier_ticket.supplier_id }
    assert_redirected_to supplier_ticket_path(assigns(:supplier_ticket))
  end

  test "should destroy supplier_ticket" do
    assert_difference('SupplierTicket.count', -1) do
      delete :destroy, id: @supplier_ticket
    end

    assert_redirected_to supplier_tickets_path
  end
end
