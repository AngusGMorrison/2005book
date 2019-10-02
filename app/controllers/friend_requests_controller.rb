class FriendRequestsController < ApplicationController

    def index
        current_user
        @requests = current_user.friend_requests_as_receiver
        @pending_requests = current_user.friend_requests_as_requestor
    end

    def create
        @friend_request = FriendRequest.new(friend_request_params)
        if @friend_request.valid?
            @friend_request.save
            current_user
            redirect_to friend_requests_path
        else
            redirect_to friend_requests_path
        end
    end

    def destroy
        @friend_request = FriendRequest.find(params[:id])
        @friend_request.destroy
        redirect_to friend_requests_path
    end

    private

    def friend_request_params
        params.require(:friend_request).permit(:requestor_id, :receiver_id)
    end

end