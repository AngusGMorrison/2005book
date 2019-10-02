class Friendship < ApplicationRecord
    include Friendship::Validations
    
    belongs_to :user_1, class_name: :User
    belongs_to :user_2, class_name: :User

    def self.get_friendship(user_1, user_2)
        Friendship.find_by(user_1_id: user_1.id, user_2_id: user_2.id) || Friendship.find_by(user_1_id: user_2.id, user_2_id: user_1.id)
    end
    
end