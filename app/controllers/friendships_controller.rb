class FriendshipsController < ApplicationController


    def index
        
    end

    def new
        @friendship = Friendship.new
    end

    # sending a friend request initialises a new instance of Friendship with a status of "Pending"
    def create
        @friend_request = Friendship.new(friendship_params)
        if @friend_request.valid?
            @friend_request.save
            current_user #resets current user to update current user's request statuses
            @profile = Profile.find_by(user_id: @friend_request.friend_id)
            redirect_to requests_path
        else
            redirect_to requests_path
        end
    end

    # friendship status is updated to "Accepted" when the friend accepts the request
    def update
        byebug
        @friendship = Friendship.find(params[:id])
        @friendship.update(friendship_params)
        if @friendship.valid?
            current_user
            redirect_to requests_path
        else 
            # Add error message
            redirect_to requests_path
        end
    end

    def destroy
        @friendship = Friendship.find(params[:id])
        @friendship.destroy
        redirect_to friends_path
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
