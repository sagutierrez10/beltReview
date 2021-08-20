class UsersController < ApplicationController

    def index
        @users = User.all
    end

    def login
        @user = User.find_by(email: user_params[:email])
        if @user
            session[:user_id] = @user.id
            redirect_to '/events'
        else
            flash[:errors] = ['Wrong email or password']
            redirect_to :back
        end
    end
    def logout
        reset_session
        redirect_to '/users'
    end
    def show
        render 'index'
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update user_params
            redirect_to '/events', notice:"You have successfully updated your profile"
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to :back
        end
    end

    def create
        @user = User.new(user_params)
        p user_params
        if @user.save
            redirect_to :back, notice: "You have successfully registered!"
        else
            flash[:errors] = @user.errors.full_messages
            redirect_to :back
        end
    end

    private
    def user_params
        params.require(:user).permit(:first_name,:last_name,:email,:city,:state,:password,:confirm_password)
    end
end
