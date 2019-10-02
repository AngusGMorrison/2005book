require 'rails_helper'
require 'faker'

RSpec.describe FriendRequest, type: :model do 
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
    end

    it "creates a new instance of FriendRequest when given two user IDs" do 
        FriendRequest.create(requestor_id: User.first.id, receiver_id: User.second.id)
        expect(FriendRequest.all.length).to eq(1)
    end

    it "doesn't allow two users to have more than one FriendRequest" do 
        FriendRequest.create(requestor_id: User.second.id, receiver_id: User.first.id)
        FriendRequest.create(requestor_id: User.first.id, receiver_id: User.second.id)
        expect(FriendRequest.all.length).to eq(1)
    end

    it "doesn't let a user send a friend request to themselves" do 
        FriendRequest.create(requestor_id: User.first.id, receiver_id: User.first.id)
        expect(FriendRequest.all.length).to eq(0)
    end

end