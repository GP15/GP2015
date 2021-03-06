require 'test_helper'

class ContactRequestsControllerTest < ActionController::TestCase
  setup do
    @contact_request = contact_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contact_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contact_request" do
    assert_difference('ContactRequest.count') do
      post :create, contact_request: { email: @contact_request.email, zipcode: @contact_request.zipcode }
    end

    assert_redirected_to contact_request_path(assigns(:contact_request))
  end

  test "should show contact_request" do
    get :show, id: @contact_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contact_request
    assert_response :success
  end

  test "should update contact_request" do
    patch :update, id: @contact_request, contact_request: { email: @contact_request.email, zipcode: @contact_request.zipcode }
    assert_redirected_to contact_request_path(assigns(:contact_request))
  end

  test "should destroy contact_request" do
    assert_difference('ContactRequest.count', -1) do
      delete :destroy, id: @contact_request
    end

    assert_redirected_to contact_requests_path
  end
end
