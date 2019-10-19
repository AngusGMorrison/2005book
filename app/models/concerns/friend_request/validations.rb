module FriendRequest::Validations
    extend ActiveSupport::Concern

    included do 
        
        def friend_request_doesnt_already_exist?
            if FriendRequest.get_friend_request(self.requestor_id, self.receiver_id)
                self.errors.add(:requestor_id, "A friend_request already exists between these two users")
            end
        end

        def friendship_doesnt_already_exist?
            if Friendship.get_friendship(self.requestor_id, self.receiver_id)
                self.errors.add(:requestor_id, "There users are already friends")
            end
        end

        def friend_request_not_with_oneself?
            if self.requestor_id == self.receiver_id 
                self.errors.add(:requestor_id, "User cannot add themselves as a friend")
            end
        end

        validates :requestor_id, presence: true

        validates :receiver_id, presence: true

        validate :friend_request_doesnt_already_exist?

        validate :friend_request_not_with_oneself?
    end

  end