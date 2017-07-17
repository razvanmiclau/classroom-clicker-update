class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_or_guest_user
  layout :custom_layout

  def custom_layout
    if devise_controller? && action_name != 'edit'
      "home-layout"
    else
      "application"
    end
  end

  # Returns user or guest user
  # Code provided by the Devise Gem Documentation
  # https://github.com/plataformatec/devise/wiki/How-To:-Create-a-guest-user
  def current_or_guest_user
    if current_user
      if session[:guest_user_id] && session[:guest_user_id] != current_user.id
        guest_user(with_retry = false).reload.try(:destroy)
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  def guest_user(with_retry = true)
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)
  rescue ActiveRecord::RecordNotFound
    session[:guest_user_id] = nil
    guest_user if with_retry
  end

  private
    def create_guest_user
      token = SecureRandom.base64(15)
      guest = User.create(:first_name => "#{Faker::Name.first_name}", :last_name => "#{Faker::StarWars.droid}",:password => token, :email => "guest_#{Time.now.to_i}#{rand(100)}@example.com")
      guest.save!(:validate => false)
      session[:guest_user_id] = guest.id
      guest
    end
end
