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
        if @friend_request.valid?
            current_user #resets current user to update current user's request statuses
            @profile = Profile.find_by(user_id: @friend_request.friend_id)
            redirect_to profile_path(@profile.slug)
        else
            redirect_to users_path
        end
    end

    # friendship status is updated to "Accepted" when the friend accepts the request
    def update 
        @friendship = Friendship.find(params[:id])
        @friendship.update(friendship_params)
        redirect_to requests_path
    end

    def destroy
        @friendship = Friendship.find(params[:id])
        @friendship.destroy
        redirect_to "/users/index"
    end

    def requests
        @friend_requests = current_user.friend_requests
        @pending_requests = current_user.pending_requests
    end

    private

    def friendship_params
        params.require(:friendship).permit(:user_id, :friend_id, :status)
    end



end
