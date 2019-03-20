require "application_system_test_case"

class Hotline::ServicesTest < ApplicationSystemTestCase
  setup do
    @hotline_service = hotline_services(:one)
  end

  test "visiting the index" do
    visit hotline_services_url
    assert_selector "h1", text: "Hotline/Services"
  end

  test "creating a Service" do
    visit hotline_services_url
    click_on "New Hotline/Service"

    fill_in "Category", with: @hotline_service.category_id
    fill_in "Href", with: @hotline_service.href
    fill_in "Value", with: @hotline_service.value
    click_on "Create Service"

    assert_text "Service was successfully created"
    click_on "Back"
  end

  test "updating a Service" do
    visit hotline_services_url
    click_on "Edit", match: :first

    fill_in "Category", with: @hotline_service.category_id
    fill_in "Href", with: @hotline_service.href
    fill_in "Value", with: @hotline_service.value
    click_on "Update Service"

    assert_text "Service was successfully updated"
    click_on "Back"
  end

  test "destroying a Service" do
    visit hotline_services_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Service was successfully destroyed"
  end
end
