require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    mod = Mod.create(name: "Test Mod")

    @user = User.create(
      name: "Test User",
      mod_id: mod.id,
      email: "test@email.com",
      password: "password",
      accepted_terms: true)

    @profile = Profile.create(user_id: @user.id)
  end

  it "creates an instance of user" do
    expect(User.last.name).to eq("Test User")
  end

  it "destroys its associated profile when it is destroyed" do
    @user.destroy
    expect(Profile.all).to be_empty
  end

end
