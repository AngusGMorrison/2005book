module Friendship::Validations
    extend ActiveSupport::Concern

    include do 
        
        def friendship_doesnt_already_exist?
            if Friendship.find_by(user_id: self.user_id, friend_id: self.friend_id) || Friendship.find_by(user_id: self.friend_id, friend_id: self.user_id)
                self.errors.add(:friend_id, "A friendship already exists between these two users!")
            end
        end

        validates :status, inclusion: { in: ["Pending", "Accepted"] }

        validates :user_id, presence: true

        validates :friend_id, presence: true

        validate :friendship_doesnt_already_exist?

    end

  end