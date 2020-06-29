# frozen_string_literal: true

class RepositoriesController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  require 'base64'
  require 'tempfile'

  # GET /users
  # GET /users.json
  def index
    @repositories = Repository
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @repository
  end

  def create
        @repository = Repository.create!(name: user_params[:name],
                             description: user_params[:description])
        @relation = UserRepositories.create!(user_id:@current_user.id, repository_id: @repository.id, is_owner: true)
    if !@repository[:errors]
      redirect_to '/home'
    else
      notice = @repository[:errors]
      render 'new'
    end
  end

  private

  def set_repository
    @repository = Repository.find(params[:id])
  end

  def repository_params
    params.permit(:name, :description)
  end
end
