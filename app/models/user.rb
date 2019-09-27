class User < ApplicationRecord
    belongs_to :photo
    belongs_to :mod
    has_many :sent_messages, foreign_key: :sender_id, class_name: :Message
    has_many :recevied_messages, foreign_key: :receiver_id, class_name: :Message 

    has_many :friendships
    has_many :friends, through: :friendships, source: :friend
    has_many :groups, foreign_key: :admin_id
end
