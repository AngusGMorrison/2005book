class User < ApplicationRecord
    belongs_to :mod

    has_many :sent_messages, foreign_key: :sender_id, class_name: :Message
    has_many :recevied_messages, foreign_key: :receiver_id, class_name: :Message 

    has_many :friendships
    has_many :friends, through: :friendships, source: :friend

    has_many :groups, foreign_key: :admin_id


    has_secure_password


    validates :mod, :email, :password, {
                presence: true
              }

    validates :name, {
                presence: {
                  message: "must be at least 2 characters"
                },
                length: {
                  in: 2..30,
                  message: "must be 2-30 characters long"
                }
              }

    validates :email, {
                uniqueness: { message: "is already in use." }
              }

end
