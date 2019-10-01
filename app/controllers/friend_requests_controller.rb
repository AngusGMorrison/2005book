class FriendRequestsController < ApplicationController

    def index
        current_user
        @requests = current_user.friend_requests_as_receiver
        @pending_requests = current_user.friend_requests_as_requestor
    end

    def create

    end

    def destroy
        @friend_request = FriendRequest.find(params[:id])
        @friend_request.destroy
        redirect_to friend_requests_path
    end

end