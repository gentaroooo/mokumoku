# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to events_path, success: 'ユーザー登録が完了しました'
    else
      flash.now[:danger] = 'ユーザー登録に失敗しました'
      render :new
    end
  end

  def index
    @users = User.order(id: :desc).page(params[:page]).per(6)
  end

  def show
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page]).per(3)
    @followers = @user.followers.page(params[:page]).per(3)
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation, :introduction)
  end
end
