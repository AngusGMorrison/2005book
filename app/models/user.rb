class User < ApplicationRecord
    include User::Validations

    has_one :profile, dependent: :destroy
    
    belongs_to :mod

    has_many :sent_messages, foreign_key: :sender_id, class_name: :Message
    has_many :received_messages, foreign_key: :receiver_id, class_name: :Message 

    has_many :friendships_as_user_1, foreign_key: :user_1_id, class_name: :Friendship
    has_many :friendships_as_user_2, foreign_key: :user_2_id, class_name: :Friendship

    has_many :friend_requests_as_requestor, foreign_key: :requestor_id, class_name: :FriendRequest
    has_many :friend_requests_as_receiver, foreign_key: :receiver_id, class_name: :FriendRequest

    has_many :groups, foreign_key: :admin_id

    has_secure_password

    before_validation :strip_name

    def self.search(search, current_user)
        if search 
            results = User.where("name LIKE ?", "%" + search + "%").order(:name)
        else
            results = User.all
        end
       return results.reject{ |user| user.id == current_user.id }
    end

    # Methods for Friendships

    def friendships 
        self.friendships_as_user_1 + self.friendships_as_user_2
    end

    def friend_ids
        self.friendships.map{ |friendship| [friendship.user_1_id, friendship.user_2_id] }.flatten.reject{ |id| id == self.id }
    end

    def friends
        self.friend_ids.map{ |friend_id| User.find(friend_id) }.sort_by{ |friend| friend.name }
    end

    def friends_with?(user)
      self.friends.include?(user)
    end

    # Methods for FriendRequests

    # returns an array of received requests
    def friend_requests 
        self.friend_requests_as_receiver.sort_by{ |request| request.requestor.name }
    end

    def friend_request_ids
        self.friend_requests.map{ |friend_request| [friend_request.requestor_id, friend_request.receiver_id] }.flatten.reject{ |id| id == self.id }
    end

    # Methods for Messages

    def messages
        self.sent_messages + self.received_messages
    end

    def chain_ids
        self.messages.map{ |message| message.chain_id }.uniq
    end

    def chains 
        self.chain_ids.map{ |chain_id| Chain.find(chain_id)}
    end

    # Other methods

    def mod_name
        self.mod.name
    end

    def member_since
      self.created_at.strftime("%B %e, %Y")
    end

    def formatted_birthday
      self.birthday.strftime("%m/%d/%Y")
    end

    def owns_profile?(profile)
      self == profile.user
    end

    private

    def strip_name
      self.name = name.strip
    end



        

    

end
