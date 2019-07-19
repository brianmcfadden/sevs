require 'test_helper'

class SideEffectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @side_effect = side_effects(:one)
  end

  test "should get index" do
    get side_effects_url
    assert_response :success
  end

  test "should get new" do
    get new_side_effect_url
    assert_response :success
  end

  test "should create side_effect" do
    assert_difference('SideEffect.count') do
      post side_effects_url, params: { side_effect: { drug_id: @side_effect.drug_id, symptom_id: @side_effect.symptom_id } }
    end

    assert_redirected_to side_effect_url(SideEffect.last)
  end

  test "should show side_effect" do
    get side_effect_url(@side_effect)
    assert_response :success
  end

  test "should get edit" do
    get edit_side_effect_url(@side_effect)
    assert_response :success
  end

  test "should update side_effect" do
    patch side_effect_url(@side_effect), params: { side_effect: { drug_id: @side_effect.drug_id, symptom_id: @side_effect.symptom_id } }
    assert_redirected_to side_effect_url(@side_effect)
  end

  test "should destroy side_effect" do
    assert_difference('SideEffect.count', -1) do
      delete side_effect_url(@side_effect)
    end

    assert_redirected_to side_effects_url
  end
end
