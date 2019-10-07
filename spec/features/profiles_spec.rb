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
  let(:submit_edits) { click_on "Update Profile" }



  it "allows name to be edited correctly" do
    edit_profile
    fill_in "profile_user_name", with: ""
    fill_in "profile_user_name", with: "Passed Test User"
    submit_edits
    expect(page).to have_current_path(profile_path(slug)).and have_css("td", text: "Passed Test User")
  end

  it "autofills the edited name on subsequent edit" do
    edit_profile
    fill_in "profile_user_name", with: ""
    fill_in "profile_user_name", with: "Passed Test User"
    submit_edits
    edit_profile
    expect(page).to have_current_path(edit_profile_path(slug)).and have_selector("input[value='Passed Test User']")
  end

  it "allows mod to be edited correctly" do
    Mod.create(name: "Test Mod 2")
    edit_profile
    page.select("Test Mod 2", from: "profile_user_mod_id")
    submit_edits
    expect(page).to have_current_path(profile_path(slug)).and have_css("td", text: "Test Mod 2")
  end

  it "autofills the selected mod on subsequent edit" do
    Mod.create(name: "Test Mod 2")
    edit_profile
    page.select("Test Mod 2", from: "profile_user_mod_id")
    submit_edits
    edit_profile
    expect(html).to include('<option selected="selected" value="2">')
  end

  it "allows studies to be edited correctly" do
    edit_profile
    fill_in "profile_studies", with: "Coding"
    submit_edits
    expect(page).to have_current_path(profile_path(slug)).and have_css("td", text: "Coding")
  end

  it "autofills the edited studies on subsequent edit" do
    edit_profile
    fill_in "profile_studies", with: "Coding"
    submit_edits
    edit_profile
    expect(page).to have_current_path(edit_profile_path(slug)).and have_selector("input[value='Coding']")
  end
    

  it "allows sex to be edited correctly" do
    edit_profile
    fill_in "profile_sex", with: "Bot"
    submit_edits
    expect(page).to have_current_path(profile_path(slug)).and have_css("td", text: "Bot")
  end

  it "autofills the edited sex on subsequent edit" do
    edit_profile
    fill_in "profile_sex", with: "Bot"
    submit_edits
    edit_profile
    expect(page).to have_current_path(edit_profile_path(slug)).and have_selector("input[value='Bot']")
  end

  it "allows birthday to be edited correctly" do
    edit_profile
    page.select("January", from: "profile_user_birthday_2i")
    page.select("1", from: "profile_user_birthday_3i")
    page.select("2000", from: "profile_user_birthday_1i")
    submit_edits
    expect(page).to have_current_path(profile_path(slug)).and have_css("td", text: "01/01/2000")
  end

  it "autofills the edited birthday on subsequent edit" do
    edit_profile
    page.select("January", from: "profile_user_birthday_2i")
    page.select("1", from: "profile_user_birthday_3i")
    page.select("2000", from: "profile_user_birthday_1i")
    submit_edits
    edit_profile
    expect(html).to include('<option value="1" selected="selected">January').and include('<option value="1" selected="selected">1').and include('<option value="2000" selected="selected">')
  end


  it "allows email to be edited correctly" do
    edit_profile
    fill_in "profile_user_email", with: "newemail@test.com"
    submit_edits
    expect(page).to have_current_path(profile_path(slug)).and have_css("td", text: "newemail@test.com")
  end

  it "autofills the edited email on subsequent edit" do
    edit_profile
    fill_in "profile_user_email", with: "newemail@test.com"
    submit_edits
    edit_profile
    expect(page).to have_current_path(edit_profile_path(slug)).and have_selector("input[value='newemail@test.com']")
  end

  it "allows screenname to be edited correctly" do
    edit_profile
    fill_in "profile_screenname", with: "Gadnuk"
    submit_edits
    expect(page).to have_current_path(profile_path(slug)).and have_css("td", text: "Gadnuk")
  end

  it "autofills the screenname on subsequent edit" do
    edit_profile
    fill_in "profile_screenname", with: "Gadnuk"
    submit_edits
    edit_profile
    expect(page).to have_current_path(edit_profile_path(slug)).and have_selector("input[value='Gadnuk']")
  end

  it "allows phone number to be edited correctly" do
    edit_profile
    fill_in "profile_phone_number", with: "06688234765"
    submit_edits
    expect(page).to have_current_path(profile_path(slug)).and have_css("td", text: "06688234765")
  end

  it "autofills the phone number on subsequent edit" do
    edit_profile
    fill_in "profile_phone_number", with: "06688234765"
    submit_edits
    edit_profile
    expect(page).to have_current_path(edit_profile_path(slug)).and have_selector("input[value='06688234765']")
  end

  it "allows websites to be edited correctly" do
    edit_profile
    fill_in "profile_websites", with: "www.facebook.com"
    submit_edits
    expect(page).to have_current_path(profile_path(slug)).and have_css("td", text: "www.facebook.com")
  end

  it "autofills the websites on subsequent edit" do
    edit_profile
    fill_in "profile_websites", with: "www.facebook.com"
    submit_edits
    edit_profile
    expect(page).to have_current_path(edit_profile_path(slug)).and have_selector("input[value='www.facebook.com']")
  end

  it "allows Looking For to be edited correctly" do
    create_looking_for_options
    edit_profile
    check "profile_looking_for_options_1"
    check "profile_looking_for_options_2"
    submit_edits
    expect(page).to have_current_path(profile_path(slug)).and have_css("td", text: "Friendship, Dating")
  end

  it "autofills Looking For on subsequent edit" do
    create_looking_for_options
    edit_profile
    check "profile_looking_for_options_1"
    check "profile_looking_for_options_2"
    submit_edits
    edit_profile
    expect(html).to include('<input type="checkbox" value="1" checked="checked"').and include('<input type="checkbox" value="2" checked="checked"')
  end

  it "allows Interested In to be edited correctly" do
    edit_profile
    fill_in "profile_interested_in", with: "Androids"
    submit_edits
    expect(page).to have_current_path(profile_path(slug)).and have_css("td", text: "Androids")
  end

  it "autofills Interested In on subsequent edit" do
    edit_profile
    fill_in "profile_interested_in", with: "Androids"
    submit_edits
    edit_profile
    expect(page).to have_current_path(edit_profile_path(slug)).and have_selector("input[value='Androids']")
  end

  it "allows Politcal Views to be edited correctly" do
    edit_profile
    page.select("Pirate Party", from: "profile_political_view_id")
    submit_edits
    expect(page).to have_current_path(profile_path(slug)).and have_css("td", text: "Pirate Party")
  end

  it "autofills Political Views on subsequent edit" do
    edit_profile
    page.select("Pirate Party", from: "profile_political_view_id")
    submit_edits
    edit_profile
    expect(html).to include('<option selected="selected" value="1">Pirate Party')
  end


  it "allows Interests to be edited correctly" do
    edit_profile
    fill_in "profile_interests", with: "Learning"
    submit_edits
    expect(page).to have_current_path(profile_path(slug)).and have_css("td", text: "Learning")
  end

  it "autofills Interests on subsequent edit" do
    edit_profile
    fill_in "profile_interests", with: "Learning"
    submit_edits
    edit_profile
    expect(page).to have_current_path(edit_profile_path(slug)).and have_content("Learning")
  end

  it "allows Favorite Books to be edited correctly" do
    edit_profile
    fill_in "profile_books", with: "C++ For Dummies"
    submit_edits
    expect(page).to have_current_path(profile_path(slug)).and have_css("td", text: "C++ For Dummies")
  end

  it "autofills Favorite Books on subsequent edit" do
    edit_profile
    fill_in "profile_books", with: "C++ For Dummies"
    submit_edits
    edit_profile
    expect(page).to have_current_path(edit_profile_path(slug)).and have_content("C++ For Dummies")
  end

  it "allows Favorite Movies to be edited correctly" do
    edit_profile
    fill_in "profile_movies", with: "The Matrix"
    submit_edits
    expect(page).to have_current_path(profile_path(slug)).and have_css("td", text: "The Matrix")
  end

  it "autofills Favorite Movies on subsequent edit" do
    edit_profile
    fill_in "profile_movies", with: "The Matrix"
    submit_edits
    edit_profile
    expect(page).to have_current_path(edit_profile_path(slug)).and have_content("The Matrix")
  end

  it "allows Favorite Music to be edited correctly" do
    edit_profile
    fill_in "profile_music", with: "The Social Network Soundtrack"
    submit_edits
    expect(page).to have_current_path(profile_path(slug)).and have_css("td", text: "The Social Network Soundtrack")
  end

  it "autofills Favorite Music on subsequent edit" do
    edit_profile
    fill_in "profile_music", with: "The Social Network Soundtrack"
    submit_edits
    edit_profile
    expect(page).to have_current_path(edit_profile_path(slug)).and have_content("The Social Network Soundtrack")
  end

  it "allows About Me to be edited correctly" do
    edit_profile
    fill_in "profile_about_me", with: "Test bot bleep bloop"
    submit_edits
    expect(page).to have_current_path(profile_path(slug)).and have_css("td", text: "Test bot bleep bloop")
  end

  it "autofills About Me on subsequent edit" do
    edit_profile
    fill_in "profile_about_me", with: "Test bot bleep bloop"
    submit_edits
    edit_profile
    expect(page).to have_current_path(edit_profile_path(slug)).and have_content("Test bot bleep bloop")
  end


end