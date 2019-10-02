class FriendRequest < ApplicationRecord
    include FriendRequest::Validations

    belongs_to :requestor, class_name: :User
    belongs_to :receiver, class_name: :User

    def get_requestor
        User.find(self.requestor_id)
    end

    def get_receiver
        User.find(self.receiver_id)
    end

    def self.get_friend_request(user_1_id, user_2_id)
        FriendRequest.find_by(requestor_id: user_1_id, receiver_id: user_2_id) || FriendRequest.find_by(requestor_id: user_2_id, receiver_id: user_1_id)
    end


end