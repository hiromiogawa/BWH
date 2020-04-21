class OwnershipsController < ApplicationController

  def create
    @car = Car.find(params[:car_id])
    if params[:type] == 'Have'
      current_user.have(@car)
      flash[:success] = 'マイカーを追加しました'
    end

    redirect_to @car
  end

  def destroy
    @car = Car.find(params[:car_id])
    if params[:type] == 'Have'
      current_user.unhave(@car)
      flash[:success] = 'マイカーから削除しました'
    end

    redirect_to @car
  end
end
