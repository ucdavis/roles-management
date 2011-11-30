require 'test_helper'

class ClassificationsControllerTest < ActionController::TestCase
  setup do
    @classification = classifications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:classifications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create classification" do
    assert_difference('Classification.count') do
      post :create, classification: @classification.attributes
    end

    assert_redirected_to classification_path(assigns(:classification))
  end

  test "should show classification" do
    get :show, id: @classification.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @classification.to_param
    assert_response :success
  end

  test "should update classification" do
    put :update, id: @classification.to_param, classification: @classification.attributes
    assert_redirected_to classification_path(assigns(:classification))
  end

  test "should destroy classification" do
    assert_difference('Classification.count', -1) do
      delete :destroy, id: @classification.to_param
    end

    assert_redirected_to classifications_path
  end
end
