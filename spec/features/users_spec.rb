require "rails_helper"

RSpec.describe "Users", type: :feature do
  before(:all) do
    Mod.create(name: "Test Mod")
  end

  before(:each) do
    visit register_path
  end

  let(:fill_name) { fill_in "user_name", with: "Test User" }
  let(:select_mod) { page.select("Test Mod", from: "user_mod_id") }
  let(:check_terms) { check "user_accepted_terms" }
  let(:submit) { click_on "Register Now!" }

  def fill_email
    within("form.registration-form") do
      fill_in "user_email", with: "test2@test.com"
    end
  end

  def fill_password
    within("form.registration-form") do
      fill_in "user_password", with: "password"
    end
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