class UsersController < ApplicationController
    # before_action :require_logged_in, only: [:index, :show, :edit, :update, :destroy]
    before_action :require_logged_in, except: [:new, :create]

    def index
        # debugger
        # params[:id]???? => answer: nope
        users = User.all
        render json: users
    end

    def new
        @user = User.new
        render :new
    end

    def edit
        @user = User.find_by(id: params[:id])
        render :edit
    end

    def show
        # debugger
        user = User.find_by(id: params[:id])
        render json: user
    end

    def create
        user = User.new(user_params)
        if user.save
            render json: user
        else
            render json: user.errors.full_messages, status: 422
        end
    end

    def update
        user = User.find_by(id: params[:id])
        if user.update(user_params)
            # render json: user
            redirect_to user_url(user)
        else
            render json: user.errors.full_messages, status: 422
        end
    end
    
    def destroy
        user = User.find_by(id: params[:id])
        if user.destroy
            render json: "Bye bye user"
        else
            render json: "Unsuccessful"
        end
    end

    private
     def user_params
        params.require(:user).permit(:username, :age, :email, :is_cool?)
     end
end
