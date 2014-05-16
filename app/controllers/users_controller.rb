class UsersController < ApplicationController
  before_action :set_user, :add_email

  def add_email
    if params[:user] && params[:user][:email]
      current_user.email = params[:user][:email]

      # Note: When using the Devise confirmable module I choose to skip email validation
      # here if the user has signed up with Twitter.
      # Just remove the following line if you want the user to confirm their email address. 
      current_user.skip_reconfirmation!

      if current_user.save
          redirect_to root_path, notice: 'Your email address was successfully updated.'
      else
          @show_errors = true
      end
    end
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end
end

