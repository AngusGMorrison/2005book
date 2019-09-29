require "rails_helper"

RSpec.describe "Homepage", type: :feature do
  before do
    visit root_path
  end

  it "has a link to log in" do
    click_on "Login"
    expect(page).to have_current_path(login_path)
  end

  it "has a link to register" do
    click_on "Register"
    expect(page).to have_current_path(register_path)
  end

end