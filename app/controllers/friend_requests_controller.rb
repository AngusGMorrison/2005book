class FriendRequestsController < ApplicationController

    def create
        @friend_request = FriendRequest.new(friend_request_params)
        if @friend_request.valid?
            @friend_request.save
            current_user
            flash[:notice] = "Friend Request sent to #{@friend_request.get_receiver.name}."
            redirect_to friends_path(current_user)
        else
            flash[:notice] = "Could not send friend request to #{@friend_request.get_receiver.name}."
            redirect_to friends_path(current_user)
        end
    end

    def destroy
        @friend_request = FriendRequest.find(params[:id])
        @friend_request.destroy
        flash[:notice] = "Friend Request from #{@friend_request.get_requestor.name} has been deleted."
        redirect_to friend_requests_path
    end

    private

    def friend_request_params
        params.require(:friend_request).permit(:requestor_id, :receiver_id)
    end

end