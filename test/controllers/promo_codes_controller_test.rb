require 'test_helper'

class PromoCodesControllerTest < ActionController::TestCase
  setup do
    @promo_code = promo_codes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:promo_codes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create promo_code" do
    assert_difference('PromoCode.count') do
      post :create, promo_code: { code: @promo_code.code, name: @promo_code.name }
    end

    assert_redirected_to promo_code_path(assigns(:promo_code))
  end

  test "should show promo_code" do
    get :show, id: @promo_code
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @promo_code
    assert_response :success
  end

  test "should update promo_code" do
    patch :update, id: @promo_code, promo_code: { code: @promo_code.code, name: @promo_code.name }
    assert_redirected_to promo_code_path(assigns(:promo_code))
  end

  test "should destroy promo_code" do
    assert_difference('PromoCode.count', -1) do
      delete :destroy, id: @promo_code
    end

    assert_redirected_to promo_codes_path
  end
end
