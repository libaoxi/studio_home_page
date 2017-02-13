require 'test_helper'

class UpdateApksControllerTest < ActionController::TestCase
  setup do
    @update_apk = update_apks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:update_apks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create update_apk" do
    assert_difference('UpdateApk.count') do
      post :create, update_apk: { filename: @update_apk.filename, name: @update_apk.name, version: @update_apk.version }
    end

    assert_redirected_to update_apk_path(assigns(:update_apk))
  end

  test "should show update_apk" do
    get :show, id: @update_apk
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @update_apk
    assert_response :success
  end

  test "should update update_apk" do
    patch :update, id: @update_apk, update_apk: { filename: @update_apk.filename, name: @update_apk.name, version: @update_apk.version }
    assert_redirected_to update_apk_path(assigns(:update_apk))
  end

  test "should destroy update_apk" do
    assert_difference('UpdateApk.count', -1) do
      delete :destroy, id: @update_apk
    end

    assert_redirected_to update_apks_path
  end
end
