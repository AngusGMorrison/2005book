class Profile < ApplicationRecord
  belongs_to :user
  has_many :profile_looking_for_options
  has_many :looking_for_options, through: :profile_looking_for_options

  belongs_to :political_view, optional: true

  URL_UNSAFE_CHARS = /[\/&\$\+\,\:\;=\?@# <>\[\]\{\}\|\\\^\%]/
  LOOKING_FOR_OPTIONS = [
                          "Friendship",
                          "Dating",
                          "A Relationship",
                          "Random play",
                          "Whatever I can get"
                        ]

  def self.create_profile_with_slug(user_id)
    profile = Profile.create(user_id: user_id)
    profile.generate_slug
  end

  def generate_slug
    unique_url_safe_name = get_unique_url_safe_name   
    self.slug = unique_url_safe_name.join("-")
    self.save
  end

  def last_update
    self.updated_at.strftime("%B %e, %Y")
  end

  private

  def get_unique_url_safe_name
    @profile_user = User.find(self.user_id)
    url_safe_name = get_url_safe_name
    make_name_unique(url_safe_name)
  end

  def get_url_safe_name
    @profile_user.name.downcase.split(URL_UNSAFE_CHARS)
  end

  def make_name_unique(name)
    name << @profile_user.id
  end


end