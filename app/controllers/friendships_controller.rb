class FriendshipsController < ApplicationController

    def index
        @friends = current_user.friends
    end

    # def new
    #     @friendship = Friendship.new
    # end

    def create
      byebug
        @friendship = Friendship.new(friendship_params)
        if @friendship.valid?
            @friendship.save
            current_user #resets current user to update current user's request statuses
            new_friend = @friendship.get_friend(current_user)
            @request = FriendRequest.get_friend_request(params[:friendship][:user_1_id], params[:friendship][:user_2_id])
            @request.destroy
            flash[:notice] = "You and #{new_friend.name} are now friends."
            redirect_to friends_path(current_user)
        else
            flash[:notice] = "Could not create friendships."
            redirect_to friends_path(current_user)
        end
    end

    def destroy
        @friendship = Friendship.find(params[:id])
        old_friend = @friendship.get_friend(current_user)
        @friendship.destroy
        flash[:notice] = "You have removed #{old_friend.name} as a friend."
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
