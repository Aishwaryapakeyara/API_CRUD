class UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]

  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid username or password"}
    end
  end

  def login
    @user = User.find_by(username: user_params[:username])

    if @user && @user.authenticate(user_params[:password])
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Invalid username or password"}
    end
  end

  def auto_login
    render json: @user
  end

  def update
    @user = User.find(params[:id])
    if @user
      @user.update(user_params)
      render json: {user: @user, message: "User Successfully Updated."}, status: 200
    else
      render json: {error: "Unable to update user."}, status: 400
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user
      @user.destroy
      render json: {message: "User successfully destroyed! "}, status: 200
    else
      render json: {error: "Unable to destroy user."}, status: 400
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :age)
  end 
end
