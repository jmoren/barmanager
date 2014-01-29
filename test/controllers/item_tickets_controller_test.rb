require 'test_helper'

class ItemTicketsControllerTest < ActionController::TestCase
  setup do
    @item_ticket = item_tickets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:item_tickets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item_ticket" do
    assert_difference('ItemTicket.count') do
      post :create, item_ticket: { item_id: @item_ticket.item_id, quantity: @item_ticket.quantity, sub_total: @item_ticket.sub_total, ticket_id: @item_ticket.ticket_id }
    end

    assert_redirected_to item_ticket_path(assigns(:item_ticket))
  end

  test "should show item_ticket" do
    get :show, id: @item_ticket
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item_ticket
    assert_response :success
  end

  test "should update item_ticket" do
    patch :update, id: @item_ticket, item_ticket: { item_id: @item_ticket.item_id, quantity: @item_ticket.quantity, sub_total: @item_ticket.sub_total, ticket_id: @item_ticket.ticket_id }
    assert_redirected_to item_ticket_path(assigns(:item_ticket))
  end

  test "should destroy item_ticket" do
    assert_difference('ItemTicket.count', -1) do
      delete :destroy, id: @item_ticket
    end

    assert_redirected_to item_tickets_path
  end
end
