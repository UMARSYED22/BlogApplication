class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protected

  # Override Devise's default redirect after sign up
  def after_sign_up_path_for(resource)
    root_path
  end

  # Override Devise's default redirect after sign in
  def after_sign_in_path_for(resource)
    root_path
  end
end
