class Friendship < ApplicationRecord
    include Friendship::Validations
    
    belongs_to :user_1, class_name: :User
    belongs_to :user_2, class_name: :User

    def self.get_friendship(user_1, user_2)
        Friendship.find_by(user_1_id: user_1.id, user_2_id: user_2.id) || Friendship.find_by(user_1_id: user_2.id, user_2_id: user_1.id)
    end

    def get_user_1
        User.find(self.user_1_id)
    end

    def get_user_2
        User.find(self.user_2_id)
    end

    def get_friend(user)
      #Improve this method to throw an exeption if the user argument is not in the friendship
      self.user_1_id == user.id ? User.find(user_2_id) : User.find(user_1_id)
    end
    
end