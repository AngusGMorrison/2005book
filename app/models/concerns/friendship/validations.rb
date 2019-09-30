module Friendship::Validations
    extend ActiveSupport::Concern

    included do 
        
        def friendship_doesnt_already_exist?
            if Friendship.find_by(user_id: self.user_id, friend_id: self.friend_id) || Friendship.find_by(user_id: self.friend_id, friend_id: self.user_id)
                self.errors.add(:friend_id, "A friendship already exists between these two users")
            end
        end

        def user_is_not_friend?
            if self.user_id == self.friend_id 
                self.errors.add(:friend_id, "User cannot add themselves as a friend")
            end
        end

        validates :status, inclusion: { in: ["Pending", "Accepted"] }

        validates :user_id, presence: true

        validates :friend_id, presence: true

        validate :friendship_doesnt_already_exist?
        
        validate :user_is_not_friend?
    end

  end