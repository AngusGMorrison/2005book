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
        @friendship = Friendship.new(user_1_id: params[:friendship][:user_1_id], user_2_id: params[:friendship][:user_2_id])
        if @friendship.valid?
            @friendship.save
            current_user #resets current user to update current user's request statuses
            redirect_to friend_requests_path
        else
            redirect_to friend_requests_path
        end
    end

    def destroy
        @friendship = Friendship.find(params[:id])
        @friendship.destroy
        redirect_to friends_path(current_user)
    end

    def requests
        @friend_requests = current_user.friend_requests
        @pending_requests = current_user.pending_requests
    end

    private

    def friendship_params
        params.require(:friendship).permit(:user_1_id, :user_2_id)
    end



end
