require 'test_helper'

class Hotline::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hotline_category = hotline_categories(:one)
  end

  test "should get index" do
    get hotline_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_hotline_category_url
    assert_response :success
  end

  test "should create hotline_category" do
    assert_difference('Hotline::Category.count') do
      post hotline_categories_url, params: { hotline_category: { href: @hotline_category.href, name: @hotline_category.name, parent_id: @hotline_category.parent_id } }
    end

    assert_redirected_to hotline_category_url(Hotline::Category.last)
  end

  test "should show hotline_category" do
    get hotline_category_url(@hotline_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_hotline_category_url(@hotline_category)
    assert_response :success
  end

  test "should update hotline_category" do
    patch hotline_category_url(@hotline_category), params: { hotline_category: { href: @hotline_category.href, name: @hotline_category.name, parent_id: @hotline_category.parent_id } }
    assert_redirected_to hotline_category_url(@hotline_category)
  end

  test "should destroy hotline_category" do
    assert_difference('Hotline::Category.count', -1) do
      delete hotline_category_url(@hotline_category)
    end

    assert_redirected_to hotline_categories_url
  end
end
