module ProfilesSpecSupport

  def create_test_objects
    Mod.create(name: "Test Mod")
    User.create(name: "Test User", mod_id: 1, email: "test@test.com", password: "password", accepted_terms: true)
    create_profile
    create_looking_for_options
    PoliticalView.create(name: "Test View")
  end
  
  def create_profile
    profile = Profile.create(user_id: User.first.id)
    profile.generate_slug
  end
  
  def create_looking_for_options
    LookingForOption.create(name: "Friendship")
    LookingForOption.create(name: "Dating")
  end

  def login
    visit login_path
    fill_email
    fill_password
    submit_login
  end

  def fill_email
    within(".login-form") do
      fill_in "user_email", with: "test@test.com"
    end
  end

  def fill_password
    within(".login-form") do
      fill_in "user_password", with: "password"
    end
  end

  def submit_login
    within(".login-form") do
      click_on "Login"
    end
  end
end