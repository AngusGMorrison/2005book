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
    update_looking_for(permitted_params)
    update_political_views(permitted_params)
    update_profile_attributes(permitted_params)
  end

  def formatted_looking_for
    looking_for_array = self.looking_for_options.each_with_object([]) do |lfo, array|
      array << lfo.name
    end
    looking_for_array.join(", ")
  end

  def get_looking_for_option_ids
    self.looking_for_options.map(&:id)
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

  def update_looking_for(permitted_params)
    self.looking_for_options.clear

    if permitted_params[:looking_for_options]
      permitted_params[:looking_for_options].each do |selection|
        lfo = LookingForOption.find(selection)
        self.looking_for_options << lfo
      end
    end
  end

  def update_political_views(permitted_params)
    if !permitted_params[:political_view_id].empty?
      self.political_view = PoliticalView.find(permitted_params[:political_view_id])
    else
      self.political_view = nil
    end
  end

  def update_profile_attributes(params)
    params_to_reject = [ "user", "looking_for_options", "political_views" ]
    profile_params = params.reject { |k, v| params_to_reject.include?(k) }
    self.update(profile_params)
  end

end