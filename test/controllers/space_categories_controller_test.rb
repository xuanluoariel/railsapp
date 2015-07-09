require 'test_helper'

class SpaceCategoriesControllerTest < ActionController::TestCase
  setup do
    @space_category = space_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:space_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create space_category" do
    assert_difference('SpaceCategory.count') do
      post :create, space_category: { area: @space_category.area, basic_id: @space_category.basic_id, density: @space_category.density, name: @space_category.name }
    end

    assert_redirected_to space_category_path(assigns(:space_category))
  end

  test "should show space_category" do
    get :show, id: @space_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @space_category
    assert_response :success
  end

  test "should update space_category" do
    patch :update, id: @space_category, space_category: { area: @space_category.area, basic_id: @space_category.basic_id, density: @space_category.density, name: @space_category.name }
    assert_redirected_to space_category_path(assigns(:space_category))
  end

  test "should destroy space_category" do
    assert_difference('SpaceCategory.count', -1) do
      delete :destroy, id: @space_category
    end

    assert_redirected_to space_categories_path
  end
end
