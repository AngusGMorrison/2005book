class Friendship < ApplicationRecord
    include Friendship::Validations

    belongs_to :user
    belongs_to :friend, class_name: :User

    # returns an instance of Friendship if one already exists between two users
    def self.get_existing_friendship(user1, user2)
        Friendship.find_by(user_id: user1.id, friend_id: user2.id) || Friendship.find_by(user_id: user2.id, friend_id: user1.id)
    end

    def request_initiator
        User.find(self.user_id)
    end

    def request_receiver
        User.find(self.friend_id)
    end

end