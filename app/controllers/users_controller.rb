class UsersController < ApplicationController
  def edit
    @user = authorize current_user
  end

  def update
    @user = authorize current_user

    if @user.update(user_params)
      redirect_to root_url, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

    def user_params
      permitted_attributes(@user)
    end
end
