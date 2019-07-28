require "application_system_test_case"

class ClassificationsTest < ApplicationSystemTestCase
  setup do
    @classification = classifications(:one)
  end

  test "visiting the index" do
    visit classifications_url
    assert_selector "h1", text: "Classifications"
  end

  test "creating a Classification" do
    visit classifications_url
    click_on "New Classification"

    fill_in "Name", with: @classification.name
    click_on "Create Classification"

    assert_text "Classification was successfully created"
    click_on "Back"
  end

  test "updating a Classification" do
    visit classifications_url
    click_on "Edit", match: :first

    fill_in "Name", with: @classification.name
    click_on "Update Classification"

    assert_text "Classification was successfully updated"
    click_on "Back"
  end

  test "destroying a Classification" do
    visit classifications_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Classification was successfully destroyed"
  end
end
