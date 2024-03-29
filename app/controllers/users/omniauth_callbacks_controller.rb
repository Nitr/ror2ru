class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController


  [:twitter, :facebook, :linked_in].each do |provider|
    define_method provider do
      provides_callback_for(provider)
    end
  end


  private
    def provides_callback_for(provider)
      @user = User.find_for_oauth(env["omniauth.auth"], current_user)

      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
      else
        session["devise.#{provider}_data"] = env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end


end
