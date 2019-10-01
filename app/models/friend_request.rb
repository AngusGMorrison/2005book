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


end