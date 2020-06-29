class WelcomeController < ApplicationController
  skip_before_action :set_current_user
    def show
      session.delete(:current_user)
    end
  
    def error; end
  
  end
  