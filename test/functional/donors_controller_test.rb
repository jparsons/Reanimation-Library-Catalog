require 'test_helper'

class DonorsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Donor.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Donor.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Donor.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to donor_url(assigns(:donor))
  end
  
  def test_edit
    get :edit, :id => Donor.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Donor.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Donor.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Donor.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Donor.first
    assert_redirected_to donor_url(assigns(:donor))
  end
  
  def test_destroy
    donor = Donor.first
    delete :destroy, :id => donor
    assert_redirected_to donors_url
    assert !Donor.exists?(donor.id)
  end
end
