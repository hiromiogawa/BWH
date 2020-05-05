class CarsController < ApplicationController
  before_action :require_user_logged_in, only: [:edit, :update, :destroy]
  
  def index
    @cars = Car.all.order(:name)
  end

  def show
    @car = Car.find(params[:id])
    @havings_users = @car.havings_users
    @circuits = Circuit.all
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)

    if @car.save
      flash[:success] = '車種 が正常に追加されました'
      redirect_to @car
    else
      flash.now[:danger] = '車種 が追加されませんでした'
      render :new
    end
  end

  def edit
    @car = Car.find(params[:id])
  end

  def update
    @car = Car.find(params[:id])

    if @car.update(car_params)
      flash[:success] = '車種 は正常に更新されました'
      redirect_to @car
    else
      flash.now[:danger] = '車種 は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @car = Car.find(params[:id])
    @car.destroy

    flash[:success] = '車種 は正常に削除されました'
    redirect_to cars_url
  end

  private

  # Strong Parameter
  def car_params
    params.require(:car).permit(:name, :img)
  end

end
