require "application_system_test_case"

class SymptomsTest < ApplicationSystemTestCase
  setup do
    @symptom = symptoms(:one)
  end

  test "visiting the index" do
    visit symptoms_url
    assert_selector "h1", text: "Symptoms"
  end

  test "creating a Symptom" do
    visit symptoms_url
    click_on "New Symptom"

    fill_in "Name", with: @symptom.name
    click_on "Create Symptom"

    assert_text "Symptom was successfully created"
    click_on "Back"
  end

  test "updating a Symptom" do
    visit symptoms_url
    click_on "Edit", match: :first

    fill_in "Name", with: @symptom.name
    click_on "Update Symptom"

    assert_text "Symptom was successfully updated"
    click_on "Back"
  end

  test "destroying a Symptom" do
    visit symptoms_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Symptom was successfully destroyed"
  end
end
