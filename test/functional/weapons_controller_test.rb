require 'test_helper'

class WeaponsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:weapons)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_weapon
    assert_difference('Weapon.count') do
      post :create, :weapon => { }
    end

    assert_redirected_to weapon_path(assigns(:weapon))
  end

  def test_should_show_weapon
    get :show, :id => weapons(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => weapons(:one).id
    assert_response :success
  end

  def test_should_update_weapon
    put :update, :id => weapons(:one).id, :weapon => { }
    assert_redirected_to weapon_path(assigns(:weapon))
  end

  def test_should_destroy_weapon
    assert_difference('Weapon.count', -1) do
      delete :destroy, :id => weapons(:one).id
    end

    assert_redirected_to weapons_path
  end
end
