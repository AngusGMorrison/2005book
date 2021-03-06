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

    def number_of_mutual_friends(user)
      get_mutual_friends(user).length
    end

    def get_mutual_friends(user)
      self.friends & user.friends
    end

    def first_6_friends
      friends.slice(0..5)
    end

    

    # Methods for FriendRequests

    # returns an array of received requests
    def friend_requests 
        self.friend_requests_as_receiver.sort_by{ |request| request.requestor.name }
    end

    def friend_request_ids
        self.friend_requests.map{ |friend_request| [friend_request.requestor_id, friend_request.receiver_id] }.flatten.reject{ |id| id == self.id }
    end

    def sent_pending_friend_request(receiver)
      FriendRequest.find_by(requestor_id: self.id, receiver_id: receiver.id)
    end

    def received_pending_friend_request(sender)
      FriendRequest.find_by(requestor_id: sender.id, receiver_id: self.id)
    end

    # Methods for Messages

    def messages
        self.sent_messages + self.received_messages
    end

    def chain_ids
        self.messages.map{ |message| message.chain_id }.uniq
    end

    def chains 
        self.chain_ids.map{ |chain_id| Chain.find(chain_id)}.sort_by{ |chain| chain.last_message.created_at }.reverse
    end

    # Other methods

    def first_name
      self.name.split(" ").first
    end

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
