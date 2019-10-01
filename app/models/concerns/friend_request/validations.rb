module FriendRequest::Validations
    extend ActiveSupport::Concern

    included do 
        
        def friend_request_doesnt_already_exist?
            if friend_request.find_by(requestor_id: self.requestor_id, receiver_id: self.receiver_id) || friend_request.find_by(requestor_id: self.receiver_id, receiver_id: self.requestor_id)
                self.errors.add(:requestor_id, "A friend_request already exists between these two users")
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