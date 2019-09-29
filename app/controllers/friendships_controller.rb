class FriendshipsController < ApplicationController

    # returns all friends for the current user
    def index
        @friends = current_user.friends
    end

    def new
        @friendship = Friendship.new
    end

    # sending a friend request initialises a new instance of Friendship with a status of "Pending"
    def create
        @friend_request = Friendship.find_or_create_by(friendship_params)
        @friend_request.status = "Pending"
        @friend_request.save
        current_user #resets current user to update current user's request statuses
        redirect_to "/users/index"
    end

    def edit

    end

    # friendship status is updated to "Accepted" when the friend accepts the request
    def update 

    end

    def delete

    end

    def view_requests
        @requests = Friendship.all.select{ |friendship| friendship.status == "Pending"}
    end

    private

    def friendship_params
        params.permit(:user_id, :friend_id)
    end



end
