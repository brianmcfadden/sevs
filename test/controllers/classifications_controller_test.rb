require 'test_helper'

class ClassificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @classification = classifications(:one)
  end

  test "should get index" do
    get classifications_url
    assert_response :success
  end

  test "should get new" do
    get new_classification_url
    assert_response :success
  end

  test "should create classification" do
    assert_difference('Classification.count') do
      post classifications_url, params: { classification: { name: @classification.name } }
    end

    assert_redirected_to classification_url(Classification.last)
  end

  test "should show classification" do
    get classification_url(@classification)
    assert_response :success
  end

  test "should get edit" do
    get edit_classification_url(@classification)
    assert_response :success
  end

  test "should update classification" do
    patch classification_url(@classification), params: { classification: { name: @classification.name } }
    assert_redirected_to classification_url(@classification)
  end

  test "should destroy classification" do
    assert_difference('Classification.count', -1) do
      delete classification_url(@classification)
    end

    assert_redirected_to classifications_url
  end
end
