class User < ApplicationRecord
    include User::Validations

    has_one :profile, dependent: :destroy
    
    belongs_to :mod

    has_many :sent_messages, foreign_key: :sender_id, class_name: :Message
    has_many :recevied_messages, foreign_key: :receiver_id, class_name: :Message 

    has_many :friendships
    has_many :friends, through: :friendships, source: :friend

    has_many :groups, foreign_key: :admin_id

    has_secure_password

    def sent_messages
        Message.all.select{ |message| message.sender_id == self.id }
    end

    def received_messages
        Message.all.select{ |message| message.receiver_id == self.id }
    end

    def mod_name
        self.mod.name
    end

    # returns an array of a user's friend requests
    def friend_requests
        Friendship.all.select{ |friendship| friendship.status == "Pending" && friendship.friend_id == self.id }
    end

    # returns an array of all of the user's friend requests which they have sent
    def pending_requests
        Friendship.all.select{ |friendship| friendship.status == "Pending" && friendship.user_id == self.id }
    end

    # returns an array of Users who are friends with this instance of user (where Frienship status == "Accepted")
    def all_friends
        all_friendships = self.friendships.select{ |friendship| friendship.status == "Accepted" }
        all_friendships.map{ |friendship| [User.find(friendship.user_id), User.find(friendship.friend_id)] }.flatten.reject{ |friend| friend == self }
    end
        

    

end
