# frozen_string_literal: true

class AuthenticationController < ApplicationController
  # POST /auth/login
  def show; end

  def login
    session.delete(:current_user)
    @user = User.find_by_email(params[:email])
    if !(@user && @user.authenticate(params[:password]))
      redirect_to '/auth/login', notice: 'Email/contraseña invalidos'
    else
        session[:current_user] = @user
        #Rails.cache.write("current_user", @response[:user])
        redirect_to '/home'
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
