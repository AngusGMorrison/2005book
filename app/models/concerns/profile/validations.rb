module User::Validations
  extend ActiveSupport::Concern

  included do
    validates :mod, :email, {
                presence: true
              }

    validates :name, {
                presence: {
                  message: "must be at least 2 characters"
                },
                length: {
                  in: 2..30,
                  message: "must be 2-30 characters long"
                },
                format: {
                  with: /\A([a-zA-Z]+[ \-']?)+[a-zA-Z]+\z/,
                  message: "should start and end with a letter and contain only letters, - or '"
                }
              }

    validates :email, {
                uniqueness: {
                  message: "is already in use"
                },
                format: {
                  with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
                  message: "format is invalid"
                },
              }

    validates :accepted_terms, {
                acceptance: true
              }

    validates :password, {
      presence: true,
      on: :create
    }
  end
end