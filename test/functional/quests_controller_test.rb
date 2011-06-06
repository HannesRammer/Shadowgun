require 'test_helper'

class QuestsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Quest.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Quest.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Quest.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to quest_url(assigns(:quest))
  end
  
  def test_edit
    get :edit, :id => Quest.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Quest.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Quest.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Quest.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Quest.first
    assert_redirected_to quest_url(assigns(:quest))
  end
  
  def test_destroy
    quest = Quest.first
    delete :destroy, :id => quest
    assert_redirected_to quests_url
    assert !Quest.exists?(quest.id)
  end
end
