require "rails_helper"

RSpec.describe "Homepage", type: :feature do
  before do
    visit root_path
  end

  it "has a link to log in" do
    find(".banner-nav-container").click_on("login")
    expect(page).to have_current_path(login_path)
  end

  it "has a link to register" do
    find(".banner-nav-container").click_on("register")
    expect(page).to have_current_path(register_path)
  end

end