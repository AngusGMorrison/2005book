class FriendRequest < ApplicationRecord
    
    belongs_to :requestor, class_name: :User
    belongs_to :receiver, class_name: :User

    def request_initiator
        User.find(self.user_id)
    end

    def request_receiver
        User.find(self.friend_id)
    end

end