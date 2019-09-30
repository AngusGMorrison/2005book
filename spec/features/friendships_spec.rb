require 'rails_helper'

RSpec.describe "Friendships", type: :feature do 

    before do
        @mod = Mod.create(name: "Test Mod")
        
        i = 1
        2.times do 
            User.create(
                name: "Test User #{i}",
                mod_id: @mod.id,
                email: "test#{i}@email.com",
                password: "password",
                accepted_terms: true)
            i += 1
        end
        current_user = User.first
        visit users_path
    end
  
    it "allows the current user to add another user as a friend" do  
        click_button("request_#{User.second.id}")
        expect(Friendship.all.length).to eq(1)
        expect(current_path).to eq(login_path)
    end

    # it "allows a user to accept a friend request" do  
    #     click_button("Send Friend Request")
    #     expect(Friendship.all.length).to eq(1)
    # end

    # it "allows a user to delete a friend request" do  
    #     click_button("Send Friend Request")
    #     expect(Friendship.all.length).to eq(1)
    # end

    # it "allows a user to remove a friend" do  
    #     click_button("Send Friend Request")
    #     expect(Friendship.all.length).to eq(1)
    # end




end