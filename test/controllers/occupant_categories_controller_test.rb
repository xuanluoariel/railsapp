require 'test_helper'

class OccupantCategoriesControllerTest < ActionController::TestCase
  setup do
    @occupant_category = occupant_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:occupant_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create occupant_category" do
    assert_difference('OccupantCategory.count') do
      post :create, occupant_category: { GTWEnd: @occupant_category.GTWEnd, GTWStart: @occupant_category.GTWStart, GTWTypical: @occupant_category.GTWTypical, name: @occupant_category.name }
    end

    assert_redirected_to occupant_category_path(assigns(:occupant_category))
  end

  test "should show occupant_category" do
    get :show, id: @occupant_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @occupant_category
    assert_response :success
  end

  test "should update occupant_category" do
    patch :update, id: @occupant_category, occupant_category: { GTWEnd: @occupant_category.GTWEnd, GTWStart: @occupant_category.GTWStart, GTWTypical: @occupant_category.GTWTypical, name: @occupant_category.name }
    assert_redirected_to occupant_category_path(assigns(:occupant_category))
  end

  test "should destroy occupant_category" do
    assert_difference('OccupantCategory.count', -1) do
      delete :destroy, id: @occupant_category
    end

    assert_redirected_to occupant_categories_path
  end
end
