require 'rails_helper'

RSpec.describe Profile, type: :model do
  before do
    @mod = Mod.create(name: "Test Mod")

    @user = User.create(
      name: "Test User",
      mod_id: @mod.id,
      email: "test@email.com",
      password: "password",
      accepted_terms: true)  
  end

  it "creates a new instance Profile from a user id" do
    Profile.create(user_id: @user.id)
    expect(Profile.all.length).to eq(1)
  end

  it "can hold all required attributes" do
    Profile.create(
      user_id: @user.id,
      sex: "Male",
      studies: Faker::Lorem.sentence(word_count: 2),
      phone_number: Faker::PhoneNumber.phone_number ,
      screenname: Faker::Lorem.sentence(word_count: 1),
      looking_for: Faker::Lorem.sentence(word_count: 1),
      interested_in: Faker::Lorem.sentence(word_count: 2),
      relationship_status: Faker::Lorem.sentence(word_count: 2),
      political_views: Faker::Lorem.sentence(word_count: 1),
      interests: Faker::Lorem.sentence(word_count: 5),
      movies: Faker::Lorem.sentence(word_count: 3),
      music: Faker::Music.band,
      websites: Faker::Internet.url,
      about_me: Faker::Lorem.sentence(word_count: 10),
      photo_url: "https://live.staticflickr.com/5252/5403292396_0804de9bcf_b.jpg"
    )

    expect(Profile.all.length).to eq(1)
  end

  it "generates a URL-safe slug" do
    user = User.create(
      name: "Te'st Use?r^",
      mod_id: @mod.id,
      email: "test2@email.com",
      password: "password",
      accepted_terms: true)  
    profile = Profile.create(user_id: user.id)
    profile.generate_slug
    
    expect(profile.slug).to eq("te'st-use-r-2")
  end

end
