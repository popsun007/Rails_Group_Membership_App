class UsersController < ApplicationController
  def index

  end

  def login
    user = User.find_by_email(params[:email])
    if user != nil && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to "/groups"
    else
      flash[:errors] = ["Invalid Username or Password"]
      redirect_to "/sessions/new"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to "/sessions/new"
  end

  def new
  end

  def show
  end

  def edit
  end

  def create
    user = User.new(user_params)
    if user.valid?
      user.save
      session[:user_id] = user.id
      redirect_to "/groups"
    else
      redirect_to "/users/new", flash: { errors: user.errors.full_messages }
    end
  end

  def update
  end

  def destroy
  end
private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
