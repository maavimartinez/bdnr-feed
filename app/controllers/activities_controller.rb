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
      aux = 'user_'+@current_user['id'].to_s+'_activ_feed';
      @act = REDIS.lrange(aux, 0, REDIS.llen(aux))
      @activities = Array.new
      @act.each do |ac|
        ret = JSON.parse(ac)
        @activities.push(ret)
      end
    end

    def fill     
        @json = get_json()
        @json.each do |ac|
            @auxCreator = 'user_'+ac[:repository][:creator][:id].to_s+'_activ_feed';
            @title = getTitle(ac)
            REDIS.lpush(@auxCreator,  ({title:@title, repository: ac[:repository][:name], description:ac[:description], type: ac[:type], date: Time.zone.now.to_s(:short)}).to_json)
            @users = ac[:repository][:users]
            @users.each do |user|
                @aux = 'user_'+user[:id].to_s+'_activ_feed';
                REDIS.lpush(@aux,  ({title: @title, repository: ac[:repository][:name], description:ac[:description], type: ac[:type], date: Time.zone.now.to_s(:short)}).to_json)
            end
        end
        redirect_to '/home'
    end

    def getTitle(activity)
        p "holaaaa"
        p activity
        case activity[:type]
        when 1
            return activity[:user][:username] + " pushed to " + activity[:repository][:creator][:username].gsub(/\s+/, "").downcase+"/"+activity[:repository][:name].gsub(/\s+/, "").downcase
        when 2
            return activity[:user][:username] + " followed " + activity[:repository][:creator][:username].gsub(/\s+/, "").downcase+"/"+activity[:repository][:name].gsub(/\s+/, "").downcase
        when 3
            return activity[:user][:username] + " ha creado el repositorio " + activity[:repository][:creator][:username].gsub(/\s+/, "").downcase+"/"+activity[:repository][:name].gsub(/\s+/, "").downcase
        else
        end
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
        return [
            {
                repository:{
                    id: 1, 
                    name:"Repo Mavi",
                    creator:   
                    {
                    id: 1, 
                    name: "Maria Victoria",
                    surname: "Martínez",
                    email: "maavimartinez@gmail.com",
                    username: "maavimartinez"
                },
                users:[

                ]
                },
                user:{id: 1, 
                name: "Maria Victoria",
                surname: "Martínez",
                email: "maavimartinez@gmail.com",
                username: "maavimartinez",
            },
                description: "",
                type: 3
            },
            {
                repository:{
                    id: 1, 
                    name:"Repo Mavi",
                    creator:{
                        id: 1, 
                        name: "Maria Victoria",
                        surname: "Martínez",
                        email: "maavimartinez@gmail.com",
                        username: "maavimartinez"
                    },
                    users:[],
                },
                user:{id: 1, 
                name: "Maria Victoria",
                surname: "Martínez",
                email: "maavimartinez@gmail.com",
                username: "maavimartinez",
            },
               
                description: "1 commit to develop",
                type: 1
            },
            {
                repository:{
                    id: 1, 
                    name:"Repo Mavi",
                    creator:{
                id: 1, 
                name: "Maria Victoria",
                surname: "Martínez",
                email: "maavimartinez@gmail.com",
                username: "maavimartinez",
                
            },users:[]
                },
                user:{id: 1, 
                name: "Maria Victoria",
                surname: "Martínez",
                email: "maavimartinez@gmail.com",
                username: "maavimartinez",
            },
            description: "1 commit to develop",
            type: 1
        },
        {
            repository:{id: 2, 
            name:"Repo Juan",
            creator:{
                id: 2, 
                name: "Juan",
                surname: "Drets",
                email: "jdrets@hotmail.com",
                username: "juandrets"
            },
            users:[],
        },
        user:{
            id: 2, 
            name: "Juan",
            surname: "Drets",
            email: "jdrets@hotmail.com",
            username: "juandrets"
            },
            description: "1 commit to develop",
            type: 1
        },
        {
            repository:{
                id: 3, 
                name:"Repo Pale",
                creator:{
                id: 3, 
                name: "Federico",
                surname: "Palermo",
                email: "pale99@gmail.com",
                username: "pale99"
            },
            users:[
                {
                id: 2, 
                name: "Juan",
                surname: "Drets",
                email: "jdrets@hotmail.com",
                username: "jdrets"
            },
            {
                id: 1, 
                name: "Maria Victoria",
                surname: "Martínez",
                email: "maavimartinez@gmail.com",
                username: "maavimartinez"
            }
            ],
            },
            user:{
                id: 1, 
                name: "Maria Victoria",
                surname: "Martínez",
                email: "maavimartinez@gmail.com",
                username: "maavimartinez"
            },
            description: "Repositorio : RepoPale",
            type: 2
        },
        {
            repository:{id: 3, 
            name:"Repo Pale",
            creator:{
                id: 3, 
                name: "Federico",
                surname: "Palermo",
                email: "pale99@gmail.com",
                username: "pale99"
            },
            users:[
                {
                id: 1, 
                name: "Maria Victoria",
                surname: "Martinez",
                email: "maavimartinez@gmail.com",
                username: "maavimartinez"
        },
        {
                id: 2, 
                name: "Juan",
                surname: "Drets",
                email: "jdrets@hotmail.com",
                username: "juandrets"
            }
            ],
        },
            user:{
                id: 2, 
                name: "Juan",
                surname: "Drets",
                email: "jdrets@hotmail.com",
                username: "juandrets"
            },
            
            description: "Repositorio : RepoPale",
            type: 2
        },
        {
            repository:{
                id: 3, 
                name:"Repo Pale",
                creator:{
                    id: 3, 
                    name: "Federico",
                    surname: "Palermo",
                    email: "pale99@gmail.com",
                    username: "pale99"
                },
                users:[
                    {
                        id: 1, 
                        name: "Maria Victoria",
                        surname: "Martinez",
                        email: "maavimartinez@gmail.com",
                        username: "maavimartinez"
                    },
                    {
                        id: 2, 
                        name: "Juan",
                        surname: "Drets",
                        email: "jdrets@hotmail.com",
                        username: "juandrets"
                    }
                ]
            }, 
            user:{
                id: 1, 
                name: "Federico",
                surname: "Palermo",
                email: "pale99@gmail.com",
                username: "pale99"
            },
            description: "1 commit to develop",
            type: 1
        }
    ]
    end
  end
  

  #1- nuevo commit
  # 2- seguir