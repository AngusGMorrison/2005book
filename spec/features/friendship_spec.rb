require 'rails_helper'
require 'faker'

RSpec.describe "Friendships", type: :feature do 

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
        current_user = User.first
    end

    it "creates a friendship when a friend request is accepted" do  

    end

    it "allows a user to remove a friend" do  

    end

    it "deletes the instance of friend request after creating a friendship" do 

    end

end