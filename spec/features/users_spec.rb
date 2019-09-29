require "rails_helper"

RSpec.describe "Users", type: :feature do
  let(:fill_name) { fill_in "user_name", with: "Test User" }
  let(:select_mod) { page.select("Test Mod", from: "user_mod_id") }
  let(:fill_email) { fill_in "user_email", with: "test@test.com" }
  let(:fill_password) { fill_in "user_password", with: "password" }
  let(:check_terms) { check "user_accepted_terms" }
  let(:submit) { click_on "Register Now!" } 

  before do
    Mod.create(name: "Test Mod")

    visit register_path
  end

  it "allows site visitors to register" do  
    fill_name
    select_mod
    fill_email
    fill_password
    check_terms
    submit
    
    expect(current_path).to include("test-user-1")
  end

  it "doesn't allow visitors to register without a name" do
    select_mod
    fill_email
    fill_password
    check_terms
    submit

    expect(current_path).to eq(register_path)
  end

  it "doesn't allow visitors to register without an email" do
    fill_name
    select_mod
    fill_password
    check_terms
    submit

    expect(current_path).to eq(register_path)
  end

  it "doesn't allow visitors to register without a password" do  
    fill_name
    select_mod
    fill_email
    check_terms
    submit
    
    expect(current_path).to eq(register_path)
  end

  it "doesn't allow visitors to register without agreeing to T&Cs" do  
    fill_name
    select_mod
    fill_email
    fill_password
    submit
    
    expect(current_path).to eq(register_path)
  end

end