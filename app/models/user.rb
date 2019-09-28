class User < ApplicationRecord
    include User::Validations

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

end
