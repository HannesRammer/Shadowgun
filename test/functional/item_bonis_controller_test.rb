require 'test_helper'

class ItemBonisControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:item_bonis)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_item_boni
    assert_difference('ItemBoni.count') do
      post :create, :item_boni => { }
    end

    assert_redirected_to item_boni_path(assigns(:item_boni))
  end

  def test_should_show_item_boni
    get :show, :id => item_bonis(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => item_bonis(:one).id
    assert_response :success
  end

  def test_should_update_item_boni
    put :update, :id => item_bonis(:one).id, :item_boni => { }
    assert_redirected_to item_boni_path(assigns(:item_boni))
  end

  def test_should_destroy_item_boni
    assert_difference('ItemBoni.count', -1) do
      delete :destroy, :id => item_bonis(:one).id
    end

    assert_redirected_to item_bonis_path
  end
end
