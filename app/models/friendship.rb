class Friendship < ApplicationRecord
    include Friendship::Validations
    
    belongs_to :user_1, class_name: :User
    belongs_to :user_2, class_name: :User

    def request_initiator
        User.find(self.user_id)
    end

    def request_receiver
        User.find(self.friend_id)
    end

end