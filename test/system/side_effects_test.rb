require "application_system_test_case"

class SideEffectsTest < ApplicationSystemTestCase
  setup do
    @side_effect = side_effects(:one)
  end

  test "visiting the index" do
    visit side_effects_url
    assert_selector "h1", text: "Side Effects"
  end

  test "creating a Side effect" do
    visit side_effects_url
    click_on "New Side Effect"

    fill_in "Drug", with: @side_effect.drug_id
    fill_in "Symptom", with: @side_effect.symptom_id
    click_on "Create Side effect"

    assert_text "Side effect was successfully created"
    click_on "Back"
  end

  test "updating a Side effect" do
    visit side_effects_url
    click_on "Edit", match: :first

    fill_in "Drug", with: @side_effect.drug_id
    fill_in "Symptom", with: @side_effect.symptom_id
    click_on "Update Side effect"

    assert_text "Side effect was successfully updated"
    click_on "Back"
  end

  test "destroying a Side effect" do
    visit side_effects_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Side effect was successfully destroyed"
  end
end
