require 'test_helper'

class PcCharDialogSetToUserCharsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pc_char_dialog_set_to_user_chars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pc_char_dialog_set_to_user_char" do
    assert_difference('PcCharDialogSetToUserChar.count') do
      post :create, :pc_char_dialog_set_to_user_char => { }
    end

    assert_redirected_to pc_char_dialog_set_to_user_char_path(assigns(:pc_char_dialog_set_to_user_char))
  end

  test "should show pc_char_dialog_set_to_user_char" do
    get :show, :id => pc_char_dialog_set_to_user_chars(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => pc_char_dialog_set_to_user_chars(:one).to_param
    assert_response :success
  end

  test "should update pc_char_dialog_set_to_user_char" do
    put :update, :id => pc_char_dialog_set_to_user_chars(:one).to_param, :pc_char_dialog_set_to_user_char => { }
    assert_redirected_to pc_char_dialog_set_to_user_char_path(assigns(:pc_char_dialog_set_to_user_char))
  end

  test "should destroy pc_char_dialog_set_to_user_char" do
    assert_difference('PcCharDialogSetToUserChar.count', -1) do
      delete :destroy, :id => pc_char_dialog_set_to_user_chars(:one).to_param
    end

    assert_redirected_to pc_char_dialog_set_to_user_chars_path
  end
end
