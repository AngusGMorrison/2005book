class Mod < ApplicationRecord
    has_many :users

    def self.list_names
      mod_names = Mod.all.map { |mod| mod.name }
      mod_names.join(" • ")
    end
end
