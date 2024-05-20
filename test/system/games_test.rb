require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "visiting the new game page" do
    visit new_url
    assert_selector "h2", text: "Letters"
  end

  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "p", count: 10
  end

  test "submitting a word" do
    visit new_url

    fill_in "word", with: "apple"
    click_on "Send"

    assert_text "Sorry but APPLE can't be built out of"
  end

  test "submitting a non english word" do
    visit new_url

    fill_in "word", with: "appleappleapple"
    click_on "Send"

    assert_text "Sorry but APPLEAPPLEAPPLE does not seem to be a valid English word..."
  end

  test "submitting a valid word" do
    visit new_url

    fill_in "word", with: "i"
    click_on "Send"
    assert_text "Congratulations!"
  end
end
