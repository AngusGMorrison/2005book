require 'rails_helper'
require 'faker'

RSpec.describe Friendship, type: :model do 
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

    it "creates a new instance of Friendship when given two user IDs" do 
        Friendship.create(user_1_id: User.first.id, user_2_id: User.second.id)
        expect(Friendship.all.length).to eq(1)
    end

    it "doesn't allow two users to have more than one Friendship" do 
        Friendship.create(user_1_id: User.second.id, user_2_id: User.first.id)
        Friendship.create(user_1_id: User.first.id, user_2_id: User.second.id)
        expect(Friendship.all.length).to eq(1)
    end

    it "doesn't let a user send a friend request to themselves" do 
        Friendship.create(user_1_id: User.first.id, user_2_id: User.first.id)
        expect(Friendship.all.length).to eq(0)
    end

end