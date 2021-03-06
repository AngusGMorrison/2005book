class FriendshipsController < ApplicationController

    def create
        
        @friendship = Friendship.new(friendship_params)
        
        if @friendship.valid?
            @request = FriendRequest.get_friend_request(params[:friendship][:user_1_id], params[:friendship][:user_2_id])
            @request.destroy
            @friendship.save
            current_user #resets current user to update current user's request statuses
            @new_friend = @friendship.get_friend(current_user)
            flash[:notice] = "You and #{@new_friend.name} are now friends."
            redirect_to friends_path(current_user)
        else
            flash[:notice] = "Could not create friendship."
            redirect_to friends_path(current_user)
        end

    end

    def destroy

        @friendship = Friendship.find(params[:id])
        @old_friend = @friendship.get_friend(current_user)
        @friendship.destroy
        flash[:notice] = "You have removed #{@old_friend.name} as a friend."
        redirect_to friends_path(current_user)

    end

    #DELETE IF CODE DOESN'T BREAK WITHOUT
    # def requests
    #     @friend_requests = current_user.friend_requests
    #     @pending_requests = current_user.pending_requests
    # end

    private

    def friendship_params
        params.require(:friendship).permit(:user_1_id, :user_2_id)
    end

end
