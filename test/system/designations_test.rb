require "application_system_test_case"

class DesignationsTest < ApplicationSystemTestCase
  setup do
    @designation = designations(:one)
  end

  test "visiting the index" do
    visit designations_url
    assert_selector "h1", text: "Designations"
  end

  test "should create designation" do
    visit designations_url
    click_on "New designation"

    fill_in "Name", with: @designation.name
    click_on "Create Designation"

    assert_text "Designation was successfully created"
    click_on "Back"
  end

  test "should update Designation" do
    visit designation_url(@designation)
    click_on "Edit this designation", match: :first

    fill_in "Name", with: @designation.name
    click_on "Update Designation"

    assert_text "Designation was successfully updated"
    click_on "Back"
  end

  test "should destroy Designation" do
    visit designation_url(@designation)
    click_on "Destroy this designation", match: :first

    assert_text "Designation was successfully destroyed"
  end
end
