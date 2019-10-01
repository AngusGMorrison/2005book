class FriendRequest < ApplicationRecord
    include FriendRequest::Validations

    belongs_to :requestor, class_name: :User
    belongs_to :receiver, class_name: :User



end