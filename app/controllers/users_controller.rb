class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @have_cars = @user.have_cars.all
    @partake_circits = @user.partake_circits.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to login_path
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = 'ユーザー情報は正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'ユーザー情報は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    flash[:success] = 'ユーザー情報 は正常に削除されました'
    redirect_to user_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
