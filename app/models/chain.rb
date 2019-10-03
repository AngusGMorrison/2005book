class Chain < ApplicationRecord
    has_many :messages, dependent: :destroy
    
    # returns the last instance of message from this chain
    def last_message
        self.messages.max_by{ |message| message.created_at }
    end
    
    # returns an array of the two users who are participating in this instance of chain
    def users
        [User.find(self.last_message.receiver_id), User.find(self.last_message.sender_id)]
    end

end