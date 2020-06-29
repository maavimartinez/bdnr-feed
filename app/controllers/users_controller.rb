# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  require 'base64'
  require 'tempfile'

  # GET /users
  # GET /users.json
  def index
    @users = User
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user
  end

  def create
    begin
        @user = User.create!(name: user_params[:name],
                             surname: user_params[:surname],
                             email: user_params[:email],
                             password: user_params[:password])
                             if !@user[:errors]
                              redirect_to '/welcome'
                          else
                            notice = @user[:errors]
                            render 'new'
                          end
    rescue 
      return render json: { error: "There has been an error creating the user", status: 400 }, status: 400
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit( :user, :name, :surname, :email, :password)
  end
end
