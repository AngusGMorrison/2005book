require 'rails_helper'
require 'faker'

RSpec.describe "FriendRequests", type: :feature do 

    before do
        @mod = Mod.create(name: "Test Mod")
        
        5.times do 
            User.create(
                name: Faker::Name.name.gsub(/[^a-zA-Z\-\' ]/, ""),
                email: Faker::Internet.unique.email,
                birthday: Faker::Date.birthday(min_age: 18, max_age: 80),
                password: "123456",
                mod_id: Mod.all.sample.id,
                accepted_terms: true)
        end

        User.all.each do |user|
            Profile.create(
                user_id: user.id,
                sex: "Female",
                studies: Faker::Lorem.sentence(word_count: 2),
                phone_number: Faker::PhoneNumber.phone_number,
                screenname: Faker::Lorem.sentence(word_count: 1),
                interested_in: Faker::Lorem.sentence(word_count: 2),
                relationship_status: Faker::Lorem.sentence(word_count: 2),
                political_view_id: 5,
                interests: Faker::Lorem.sentence(word_count: 5),
                movies: Faker::Lorem.sentence(word_count: 3),
                music: Faker::Music.band,
                websites: Faker::Internet.url,
                about_me: Faker::Lorem.sentence(word_count: 10),
                photo_url: "https://www.ketchum.com/wp-content/uploads/2016/08/happy-emoji-1.jpg"
              )
        end

        Profile.all.each{ |profile| profile.generate_slug }

        current_user = User.first

    end

    it "redirects to the requests page after initiating a friend request" do  
        visit users_path
        test_user = User.all.sample
        click_button("#{test_user.id}")
        expect(current_path).to eq(friend_requests_path)
    end

    # it "allows a user to accept a friend request" do  
    #     test_user = User.all.sample
    #     current_user = User.first
    #     FriendRequest.create(requestor_id: test_user.id, receiver_id: current_user.id )
    #     visit friend_requests_path
    #     page.should have_selector(:link_or_button, 'Accept Friend Request')
    # end

    it "deletes the instance of friend request after the friend request has been accepted" do 

    end

    it "allows a user to reject a friend request" do  

    end




end