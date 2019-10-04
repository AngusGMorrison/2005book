class Chain < ApplicationRecord
    has_many :messages, dependent: :destroy
    
    def has_messages?
        if !Message.all.select{ |message| message.chain_id == self.id }.empty?
            return true
        else
            return false
        end
    end

    # returns the last instance of message from this chain
    def last_message
        self.messages.max_by{ |message| message.created_at }
    end
    
    # returns an array of the two users who are participating in this instance of chain
    def users
        [User.find(self.last_message.receiver_id), User.find(self.last_message.sender_id)]
    end

    # given two user ids, find an existing message chain
    def self.get_message_chain(user1_id, user2_id)
        chains_with_messages = Chain.all.select{ |chain| chain.has_messages? == true} 
        get_chain = chains_with_messages.find{ |chain| ( chain.last_message.sender_id == user1_id && chain.last_message.receiver_id == user2_id ) || ( chain.last_message.sender_id == user2_id && chain.last_message.receiver_id == user1_id )  } 
        get_chain
    end

end