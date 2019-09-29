require "rails_helper"

RSpec.describe "Sessions", type: :feature do
  let(:fill_email) { fill_in "user_email", with: "test2@test.com" }
  let(:fill_password) { fill_in "user_password", with: "password" }
  let(:submit) { click_on "Login" }

  def login
    visit login_path
    fill_email
    fill_password
    submit
  end

  before do
    @mod = Mod.create(name: "Test Mod")
    @user = User.create(
      name: "Test User",
      mod_id: @mod.id,
      email: "test2@test.com",
      password: "password",
      accepted_terms: true
    )
    @profile = Profile.create(user_id: User.first.id)
    @profile.generate_slug
  end


  it "allows a valid user to log in" do
    visit login_path
    fill_email
    fill_password
    submit
    expect(current_path).to eq(profile_path(@profile.slug))
  end

  it "prevents users from logging in without an email" do
    visit login_path
    fill_password
    submit
    expect(current_path).to eq(login_path)
  end

  it "prevents users with invalid emails from logging in" do
    visit login_path
    fill_in "user_email", with: "fake@notexist.com"
    fill_password
    submit
    expect(current_path).to eq(login_path)
  end

  it "prevents users from logging in without a password" do
    visit login_path
    fill_email
    submit
    expect(current_path).to eq(login_path)
  end

  it "prevents users with invalid passwords from logging in" do
    visit login_path
    fill_email
    fill_in "user_password", with: "invalid"
    submit
    expect(current_path).to eq(login_path)
  end

  it "prevents users from accessing profile pages if not logged in" do
    visit profile_path(@profile.slug)
    expect(current_path).to eq(login_path)
  end

  it "doesn't allow logged-in users to register" do
    login
    visit register_path
    expect(current_path).to eq(profile_path(@profile.slug))
  end

  it "allows users to log out" do
    login
    visit logout_path
    visit profile_path(@profile.slug)
    expect(current_path).to eq(login_path)
  end

end