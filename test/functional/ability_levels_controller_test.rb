require 'test_helper'

class AbilityLevelsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => AbilityLevel.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    AbilityLevel.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    AbilityLevel.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to ability_level_url(assigns(:ability_level))
  end
  
  def test_edit
    get :edit, :id => AbilityLevel.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    AbilityLevel.any_instance.stubs(:valid?).returns(false)
    put :update, :id => AbilityLevel.first
    assert_template 'edit'
  end
  
  def test_update_valid
    AbilityLevel.any_instance.stubs(:valid?).returns(true)
    put :update, :id => AbilityLevel.first
    assert_redirected_to ability_level_url(assigns(:ability_level))
  end
  
  def test_destroy
    ability_level = AbilityLevel.first
    delete :destroy, :id => ability_level
    assert_redirected_to ability_levels_url
    assert !AbilityLevel.exists?(ability_level.id)
  end
end
