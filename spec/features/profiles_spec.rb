require "rails_helper"

RSpec.describe "New profile", type: :feature do
  before(:all) do
    create_test_objects
  end

  before(:each) do
    login
  end

  it "displays the profile owner's name" do
    expect(page).to have_content("Test User")
  end

  it "displays the profile owner's email" do
    expect(page).to have_content("test@test.com")
  end

  it "displays the profile owner's mod" do
    expect(page).to have_content(User.first.mod.name)
  end

  it "has a link to edit the profile" do
    within(".profile-information-widget") do
      click_on("[ edit ]")
    end
    expect(current_path).to eq(edit_profile_path(Profile.first.slug))
  end

end


RSpec.describe "Edit profile", type: :feature do
  before(:all) do
    create_test_objects
  end

  before(:each) do
    login
  end

  let(:user) { User.first }
  let(:slug) { user.profile.slug }
  let(:edit_profile) { visit edit_profile_path(slug) }
  let(:test_dropdown) { page.select(value, from: field_id) }
  let(:submit_edits) { click_on "Update Profile" }

  def test_text_field(field_id, value)
    edit_profile
    fill_in field_id, with: value
    submit_edits
    expect(page).to have_content(value)
  end

  def test_dropdown(field_id, value)
    edit_profile
    page.select(value, from: field_id)
    submit_edits
    expect(page).to have_content(value)
  end

  it "redirects to the profile page after edit" do
    edit_profile
    submit_edits
    expect(page).to have_current_path(profile_path(slug))
  end

  it "saves changes to Name" do
    test_text_field("profile_user_name", "Passed Test User")
  end

  it "saves changes to Mod" do
    Mod.create(name: "Test Mod 2")
    test_dropdown("profile_user_mod_id", "Test Mod 2")
  end

  it "saves changes to Studies" do
    test_text_field("profile_studies", "Coding")
  end

  it "saves changes to Sex" do
    test_text_field("profile_sex", "Bot")
  end

  it "saves changes to Screenname" do
    test_text_field("profile_screenname", "Test Screenname")
  end

  it "saves changes to Birthday" do
    edit_profile
    page.select("January", from: "profile_user_birthday_2i")
    page.select("1", from: "profile_user_birthday_3i")
    page.select("2000", from: "profile_user_birthday_1i")
    submit_edits
    expect(page).to have_content("01/01/2000")
  end

  it "saves changes to Email" do
    test_text_field("profile_user_email", "newemail@test.com")
  end

  it "saves changes to Phone Number" do
    test_text_field("profile_phone_number", "06688234765")
  end

  it "saves changes to Websites" do
    test_text_field("profile_websites", "www.test.com")
  end

  it "saves changes to Looking For" do
    create_looking_for_options
    edit_profile
    check "profile_looking_for_options_1"
    check "profile_looking_for_options_2"
    submit_edits
    expect(page).to have_content("Friendship").and have_content("Dating")
  end

  it "saves changes to Interested In" do
    test_text_field("profile_interested_in", "Androids")
  end

  it "saves changes to Political Views" do
    test_dropdown("profile_political_view_id", "Test View")
  end

  it "saves changes to Interests" do
    test_text_field("profile_interests", "Learning")
  end

  it "saves changes to Favourite Books" do
    test_text_field("profile_books", "C++ For Dummies")
  end

  it "saves changes to Favourite Movies" do
    test_text_field("profile_movies", "The Social Network")
  end

end