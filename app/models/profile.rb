class Profile < ApplicationRecord
  belongs_to :user
  has_many :profile_looking_for_options
  has_many :looking_for_options, through: :profile_looking_for_options

  belongs_to :political_view, optional: true

  URL_UNSAFE_CHARS = /[\/&\$\+\,\:\;=\?@# <>\[\]\{\}\|\\\^\%]/

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

  def update_after_edit(permitted_params)
    unless permitted_params[:looking_for].empty?
      update_looking_for(permitted_params[:looking_for])
    end
    update_profile_attributes(permitted_params)
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

  def update_looking_for(looking_for_selections)
    self.looking_for_options.clear
    looking_for_selections.each do |selection|
      lfo = LookingForOption.find(selection)
      self.looking_for_options << lfo
    end
  end

  def update_profile_attributes(params)
    profile_params = params.reject { |k, v| k == "user" || k == "looking_for" }
    self.update(profile_params)
    byebug
  end

end