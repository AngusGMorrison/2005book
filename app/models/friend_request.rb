class FriendRequest < ApplicationRecord
    
    include FriendRequest::Validations

    belongs_to :requestor, class_name: :User
    belongs_to :receiver, class_name: :User

    # given two user IDs, returns the instance of FriendRequest associated with those users
    def self.get_friend_request(user_1_id, user_2_id)
        FriendRequest.find_by(requestor_id: user_1_id, receiver_id: user_2_id) || FriendRequest.find_by(requestor_id: user_2_id, receiver_id: user_1_id)
    end

    # returns requestor as an instance of User
    def get_requestor
        User.find(self.requestor_id)
    end

    # returns the receiver as an instance of User
    def get_receiver
        User.find(self.receiver_id)
    end


end