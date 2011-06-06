require 'test_helper'

class ArmorsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:armors)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_armor
    assert_difference('Armor.count') do
      post :create, :armor => { }
    end

    assert_redirected_to armor_path(assigns(:armor))
  end

  def test_should_show_armor
    get :show, :id => armors(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => armors(:one).id
    assert_response :success
  end

  def test_should_update_armor
    put :update, :id => armors(:one).id, :armor => { }
    assert_redirected_to armor_path(assigns(:armor))
  end

  def test_should_destroy_armor
    assert_difference('Armor.count', -1) do
      delete :destroy, :id => armors(:one).id
    end

    assert_redirected_to armors_path
  end
end
