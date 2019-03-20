require 'test_helper'

class Hotline::ServicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hotline_service = hotline_services(:one)
  end

  test "should get index" do
    get hotline_services_url
    assert_response :success
  end

  test "should get new" do
    get new_hotline_service_url
    assert_response :success
  end

  test "should create hotline_service" do
    assert_difference('Hotline::Service.count') do
      post hotline_services_url, params: { hotline_service: { category_id: @hotline_service.category_id, href: @hotline_service.href, value: @hotline_service.value } }
    end

    assert_redirected_to hotline_service_url(Hotline::Service.last)
  end

  test "should show hotline_service" do
    get hotline_service_url(@hotline_service)
    assert_response :success
  end

  test "should get edit" do
    get edit_hotline_service_url(@hotline_service)
    assert_response :success
  end

  test "should update hotline_service" do
    patch hotline_service_url(@hotline_service), params: { hotline_service: { category_id: @hotline_service.category_id, href: @hotline_service.href, value: @hotline_service.value } }
    assert_redirected_to hotline_service_url(@hotline_service)
  end

  test "should destroy hotline_service" do
    assert_difference('Hotline::Service.count', -1) do
      delete hotline_service_url(@hotline_service)
    end

    assert_redirected_to hotline_services_url
  end
end
