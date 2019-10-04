module Profile::Validations
  extend ActiveSupport::Concern

  included do
    validates :studies, :sex, :hometown, :screenname, :interested_in, {
      length: {
        maximum: 30,
        message: "can't be longer than 30 characters"
      }
    }

    validates :photo_url, {
      presence: true,
      format: {
        with: /jpg|jpeg|png\z/,
        message: "must link to a jpg or png image"
      }
    }

    validates :websites, :interests, :books, :movies, :music, :about_me, {
      length: {
        maximum: 300,
        message: "can't be longer than 300 characters"
      }
    }
  end

end