class ApplicationController < ActionController::Base

    before_action :set_current_user
    attr_accessor :current_user

    def set_current_user
        puts "set current user"
        @current_user = session[:current_user]
        puts session[:current_user]
        puts @current_user.to_json
        puts 111111111111
    end

end
