class LookingForOption < ApplicationRecord
  has_many :profile_looking_for_options
  has_many :profiles, through: :profile_looking_for_options
end
