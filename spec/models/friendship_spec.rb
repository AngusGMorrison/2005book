require 'rails_helper'

RSpec.describe Friendship, type: :model do 
    before do
        @mod = Mod.create(name: "Test Mod")
        
        i = 1
        5.times do 
            User.create(
                name: "Test User #{i}",
                mod_id: @mod.id,
                email: "test#{i}@email.com",
                password: "password",
                accepted_terms: true)
            i += 1
        end

    end

    it "creates a new instance of Friendship when given two user IDs and a profile status" do 
        Friendship.create(status: "Pending", user_id: User.first.id, friend_id: User.second.id)
        expect(Friendship.all.length).to eq(1)
    end

    it "doesn't allow two users to have more than one Friendship" do 
        Friendship.create(status: "Pending", user_id: User.second.id, friend_id: User.first.id)
        Friendship.create(status: "Pending", user_id: User.first.id, friend_id: User.second.id)
        expect(Friendship.all.length).to eq(1)
    end

    it "doesn't accept status attributes other than 'Accepted' and 'Pending' " do 
        Friendship.create(status: "Pending", user_id: User.first.id, friend_id: User.second.id)
        Friendship.create(status: "Request Sent", user_id: User.third.id, friend_id: User.fourth.id)
        expect(Friendship.all.length).to eq(1)
    end

    it "doesn't let a user send a friend request to themselves" do 
        Friendship.create(status: "Pending", user_id: User.first.id, friend_id: User.first.id)
        expect(Friendship.all.length).to eq(0)
    end




end