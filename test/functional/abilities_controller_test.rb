require 'test_helper'

class AbilitiesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Ability.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Ability.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Ability.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to ability_url(assigns(:ability))
  end
  
  def test_edit
    get :edit, :id => Ability.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Ability.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Ability.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Ability.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Ability.first
    assert_redirected_to ability_url(assigns(:ability))
  end
  
  def test_destroy
    ability = Ability.first
    delete :destroy, :id => ability
    assert_redirected_to abilities_url
    assert !Ability.exists?(ability.id)
  end
end
