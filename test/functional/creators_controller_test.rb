require 'test_helper'

class CreatorsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Creator.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Creator.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Creator.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to creator_url(assigns(:creator))
  end
  
  def test_edit
    get :edit, :id => Creator.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Creator.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Creator.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Creator.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Creator.first
    assert_redirected_to creator_url(assigns(:creator))
  end
  
  def test_destroy
    creator = Creator.first
    delete :destroy, :id => creator
    assert_redirected_to creators_url
    assert !Creator.exists?(creator.id)
  end
end
