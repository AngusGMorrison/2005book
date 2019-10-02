class FriendRequestsController < ApplicationController

    def index
        current_user
        @requests = current_user.friend_requests_as_receiver
        @pending_requests = current_user.friend_requests_as_requestor
    end

    def create
        @friend_request = FriendRequest.new(requestor_id: params[:friend_request][:requestor_id], receiver_id: params[:friend_request][:receiver_id])
        if @friend_request.valid?
            @friend_request.save
            current_user #resets current user to update current user's request statuses
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

end