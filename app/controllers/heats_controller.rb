class HeatsController < ApplicationController
  before_action :require_user_logged_in, only: [:edit, :update, :destroy]

  def show
    @heat = Heat.find(params[:id])
    @laptimes = @heat.laptimes.all
    @settings = @heat.settings.all
    @datalist = @heat.datalist
    @event = @datalist.event
    @circuit = @event.circuit
    @user = @heat.user
  end

  def new
    @user = current_user
    @have_cars = @user.have_cars.all
    @event = Event.find(params[:event_id])
    @circuit = Circuit.find(params[:circuit_id])
    @datalist = @event.datalists.where(user_id: @user.id).where(event_id: @event.id).first
    @heat = @datalist.heats.build
    3.times{@heat.laptimes.build}
    @heat.settings.build
  end

  def create
    @user = current_user
    @event = Event.find(params[:event_id])
    @circuit = Circuit.find(params[:circuit_id])
    @datalist = @event.datalists.where(user_id: @user.id).where(event_id: @event.id).first
    @heat = @datalist.heats.build(heat_params)
    if @heat.save
      flash[:success] = 'データを追加しました。'
      redirect_to datalist_path(@datalist, :circuit_id => @circuit.id, :event_id => @event.id )
    else
      flash[:danger] = 'データの追加に失敗しました。'
      redirect_to datalist_path(@datalist, :circuit_id => @circuit.id, :event_id => @event.id )
    end
  end

  def edit
    @heat = Heat.find(params[:id])
    @datalist = @heat.datalist
    @event = @datalist.event
    @circuit = @event.circuit
    @user = @datalist.user
    @laptimes = @heat.laptimes.all
    @settings = @heat.settings.all
    @have_cars = @user.have_cars.all
  end

  def update
    @heat = Heat.find(params[:id])

    if @heat.update(heat_params)
      flash[:success] = '正常に更新されました'
      redirect_to @heat
    else
      flash.now[:danger] = '更新されませんでした'
      render :edit
    end
  end

  def destroy
    @heat = Heat.find(params[:id])
    @datalist = @heat.datalist
    @event = @datalist.event
    @circuit = @event.circuit
    @heat.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_to datalist_path(@datalist, :circuit_id => @circuit.id, :event_id => @event.id )
  end

  private

  def heat_params
    params.require(:heat).permit(:car_id, :circuit_id, :user_id, :tirename, :number, :weather, :temp, :roadcondition, :roadtemp,  laptimes_attributes: [:id, :sec1, :sec2, :sec3, :total ], settings_attributes: [:id, :ftirewidth, :rtirewidth, :flpress, :frpress, :rlpress, :rrpress,:flpress_after, :frpress_after, :rlpress_after, :rrpress_after, :fdecay, :rdecay, :remarks ])
  end
end
