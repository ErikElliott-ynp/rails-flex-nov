class SessionsController < ApplicationController
    before_action(:require_logged_in, {only: :destroy})
    
    def new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        if @user
            login(@user)
            redirect_to users_url
        else
            flash.now[:errors] = ["Invalid credentials"]
            render :new
        end
    end

    def destroy
        logout
        redirect_to new_session_url
    end

    # Let's not do this

    # private
    # def session_params
    #     params.require(:user).permit(:username, :password)
    # end
end