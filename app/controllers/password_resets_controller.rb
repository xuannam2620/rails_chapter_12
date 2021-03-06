class PasswordResetsController < ApplicationController
  before_action :load_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "flash.reset_email_sent"
      redirect_to root_path
    else
      flash[:danger] = t "flash.email_not_found"
      render :new
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add :password, t("password_edit.cant_be_empty")
      render :edit
    elsif @user.update_attributes(user_params)
      login @user
      @user.update_attribute :reset_digest, nil
      flash[:success] = t "flash.password_has_been_reset"
      redirect_to @user
    else
      render :edit
    end
  end

  private
    def user_params
      params .require(:user).permit :password, :password_confirmation
    end

    def load_user
      @user = User.find_by email: params[:email]
    end

    def valid_user
      unless @user && @user.activated? && @user.authenticated?(:reset,
        params[:id])
        redirect_to root_path
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = t "password_reset_expired"
        redirect_to new_password_reset_url
      end
    end
end
