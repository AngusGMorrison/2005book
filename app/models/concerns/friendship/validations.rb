module Friendship::Validations
    extend ActiveSupport::Concern

    included do 
        
        def friendship_doesnt_already_exist?
            if Friendship.get_friendship(self.user_1_id, self.user_2_id)
                self.errors.add(:requestor_id, "There users are already friends")
            end
        end

        def friendship_not_with_oneself?
            if self.user_1_id == self.user_2_id 
                self.errors.add(:user_1_id, "User cannot be friends with themselves")
            end
        end

        validates :user_1_id, presence: true

        validates :user_2_id, presence: true

        validate :friendship_doesnt_already_exist?

        validate :friendship_not_with_oneself?
    end

  end