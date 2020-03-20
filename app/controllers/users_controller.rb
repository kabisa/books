class UsersController < ApplicationController
  def edit
    @user = authorize current_user
  end

  def update
    @user = authorize current_user

    if @user.update(user_params)
      @user.crop_x = params[:user][:crop_x]
      @user.crop_y = params[:user][:crop_y]
      @user.crop_w = params[:user][:crop_w]
      @user.crop_h = params[:user][:crop_h]

      @user.save

      redirect_to root_url, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

    def user_params
      permitted_attributes(@user)
    end
end
