require "application_system_test_case"

class Hotline::CategoriesTest < ApplicationSystemTestCase
  setup do
    @hotline_category = hotline_categories(:one)
  end

  test "visiting the index" do
    visit hotline_categories_url
    assert_selector "h1", text: "Hotline/Categories"
  end

  test "creating a Category" do
    visit hotline_categories_url
    click_on "New Hotline/Category"

    fill_in "Href", with: @hotline_category.href
    fill_in "Name", with: @hotline_category.name
    fill_in "Parent", with: @hotline_category.parent_id
    click_on "Create Category"

    assert_text "Category was successfully created"
    click_on "Back"
  end

  test "updating a Category" do
    visit hotline_categories_url
    click_on "Edit", match: :first

    fill_in "Href", with: @hotline_category.href
    fill_in "Name", with: @hotline_category.name
    fill_in "Parent", with: @hotline_category.parent_id
    click_on "Update Category"

    assert_text "Category was successfully updated"
    click_on "Back"
  end

  test "destroying a Category" do
    visit hotline_categories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Category was successfully destroyed"
  end
end
