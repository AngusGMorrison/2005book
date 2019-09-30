class Message < ApplicationRecord
    belongs_to :chain
    belongs_to :sender, class_name: :User
    belongs_to :receiver, class_name: :User

    def sender_name
        User.find(self.sender_id).name
    end 

    def receiver_name
        User.find(self.receiver_id).name
    end

end
