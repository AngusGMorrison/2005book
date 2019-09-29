require "rails_helper"

RSpec.describe "Sessions", type: :feature do


  it "doesn't allow logged-in users to register" do
    user = create_user
    profile = create_profile
    profile.generate_slug
    expect(current_path).to not_eq(register_path)
  end