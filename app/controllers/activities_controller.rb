# frozen_string_literal: true

class ActivitiesController < ApplicationController
  
    def index
      @repositories = RepositoriesUser.where(user_id: @current_user['id']).all()
      @repos = Array.new
      @repositories.each do |rep|
        @repouser = RepositoriesUser.where(repository_id: rep.repository_id, is_creator:true).first()
        @us = User.find(@repouser.user_id)
        @repo = Repository.find(rep.repository_id)
        @aux = {name: @repo.name, description: @repo.description, creator: @us.name + " " + @us.surname}
        @repos.push(@aux)
      end
      aux = 'user_'+@current_user['id'].to_s+'_feed';
      @activities = REDIS.lrange(aux, 0, REDIS.llen(aux))
    # while REDIS.llen(aux) > 0
        
    #    activities.each do |act|
          # send email code here
          #REDIS.lrem(aux, 1, act)
    #    end
    #   end
    end

    def fill     
        @json = get_json()
        @json.each do |ac|
            @repo = Repository.find(ac[:repository_id])
            @users = RepositoriesUser.where(repository_id: ac[:repository_id]).all()
            @users.each do |user|
                @aux = 'user_'+user.user_id.to_s+'_feed';
                REDIS.lpush(@aux,  {repository: @repo.name, description:ac[:description], type: ac[:type], date: DateTime.now()})
            end
        end
        redirect_to '/home'
    end
  
    # GET /users/1
    # GET /users/1.json
    def show
      
    end
  
    def create
      
    end
  
    private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.permit( :user, :name, :surname, :email, :password)
    end

    def get_json()
        return [{
            repository_id: 1, 
            description: "Maria Victoria ha realizado un nuevo commit",
            type: 1
        },
        {
            repository_id: 1, 
            description: "Maria Victoria ha realizado un nuevo commit",
            type: 1
        },
        {
            repository_id: 2, 
            description: "Juan ha realizado un nuevo commit",
            type: 1
        },
        {
            repository_id: 3, 
            description: "Maria Victoria ha seguido el repositorio",
            type: 2
        },
        {
            repository_id: 3, 
            description: "Juan ha seguido el repositorio",
            type: 2
        },
        {
            repository_id: 3, 
            description: "Federico ha realizado un nuevo commit",
            type: 1
        }
    ]
    end
  end
  

  #1- nuevo commit
  # 2- seguir