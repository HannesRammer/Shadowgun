require 'test_helper'

class AreaMapsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:area_maps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create area_map" do
    assert_difference('AreaMap.count') do
      post :create, :area_map => { }
    end

    assert_redirected_to area_map_path(assigns(:area_map))
  end

  test "should show area_map" do
    get :show, :id => area_maps(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => area_maps(:one).to_param
    assert_response :success
  end

  test "should update area_map" do
    put :update, :id => area_maps(:one).to_param, :area_map => { }
    assert_redirected_to area_map_path(assigns(:area_map))
  end

  test "should destroy area_map" do
    assert_difference('AreaMap.count', -1) do
      delete :destroy, :id => area_maps(:one).to_param
    end

    assert_redirected_to area_maps_path
  end
end
