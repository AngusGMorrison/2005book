class Profile < ApplicationRecord
  belongs_to :user

  URL_UNSAFE_CHARS = /[&\$\+,/:;=\?@# <>\[\]\{\}\|\\\^\%]/

  def generate_slug
    @profile_user = User.find(self.user_id)
    name = get_unique_url_safe_name   
    url_safe_slug = name.join(".")
  end

  private

  def get_unique_url_safe_name
    url_safe_name = @profile_user.name.split(URL_UNSAFE_CHARS)
    make_name_unique(url_safe_name)
  end

  def make_name_unique(name)
    name << @profile_user.id
  end


end