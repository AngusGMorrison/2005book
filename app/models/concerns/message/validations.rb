module Message::Validations
    extend ActiveSupport::Concern

    included do 
        
        def users_are_friends?
            if !Friendship.find_by(user_1_id: self.sender_id, user_2_id: self.receiver_id) && !Friendship.find_by(user_1_id: self.receiver_id, user_2_id: self.sender_id)
                self.errors.add(:sender_id, "Cannot send messages to a user who is not a friend")
            end
        end

        def message_not_with_oneself?
            if self.sender_id == self.receiver_id 
                self.errors.add(:sender_id, "You cannot send a message to yourself")
            end
        end

        # def chain_doesnt_already_exist?
        #     if Chain.get_message_chain(self.sender_id, self.receiver_id)
        #         self.errors.add(:sender_id, "You already have a message chain with this person!")
        #     end
        # end

        validates :sender_id, presence: true

        validates :receiver_id, presence: true

        validates :content, presence: true

        validates :chain_id, presence: true

        validate :users_are_friends?

        validate :message_not_with_oneself?

        # validate :chain_doesnt_already_exist?

    end

  end