class Friendship < ApplicationRecord
    belongs_to :user
    belongs_to :friend, class_name: :User

    def request_initiator
        User.find(self.user_id)
    end

    def request_receiver
        User.find(self.friend_id)
    end

end