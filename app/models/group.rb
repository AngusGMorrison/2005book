class Group < ApplicationRecord
    belongs_to :admin, class_name: :User
    has_many :group_users
    has_many :users, through: :group_users
end
