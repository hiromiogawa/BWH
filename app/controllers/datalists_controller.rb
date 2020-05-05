class DatalistsController < ApplicationController
  before_action :require_user_logged_in, only: [:edit, :update, :destroy]

  def show
    @event = Event.find(params[:event_id])
    @circuit = Circuit.find(params[:circuit_id])
    @datalist = Datalist.find(params[:id])
    @heats = @datalist.heats.all.order(:number )
    @besttimes =
      @heats.map do |heat|
        heat.laptimes.minimum(:total)
      end
      unless @besttimes.blank?
        @besttime = @besttimes.min
        @bestheats =@heats.includes(:laptimes).where("laptimes.total": @besttime).all
      end
  end

  def create
    @event = Event.find(params[:event_id])
    @circuit = Circuit.find(params[:circuit_id])
    current_user.dataregister(@event)
    flash[:success] = 'データを登録'

    redirect_to new_heat_path(circuit_id: @circuit.id, event_id: @event.id)
  end

  def destroy
    @event = Event.find(params[:event_id])
    @circuit = Circuit.find(params[:circuit_id])
    @datalist.destroy
    current_user.undataregister(@event)
    flash[:success] = 'データを削除'

    redirect_to event_path(@event, :circuit_id => @circuit.id, id => @event.id )

  end

  def userdata
    @user = User.find(params[:user_id])
    @circuit = Circuit.find(params[:circuit_id])
    @datalists = Datalist.includes(:event ,:user).where("events.circuit_id": @circuit.id).where("datalists.user_id": @user.id).all.order(day: "DESC").page(params[:page]).per(10)
    @besttimes =
      @datalists.map do |data|
        @bestheats = data.heats.all
        @bestheats.map do |heat|
          heat.laptimes.minimum(:total)
        end
      end
    unless @besttimes.blank?
      @besttime = @besttimes.min.min
      @bestheats = Heat.includes(:laptimes).where("laptimes.total": @besttime).all
    end
  end

  def cardata
    @car = Car.find(params[:car_id])
    @circuit = Circuit.find(params[:circuit_id])
    @times = Laptime.includes(:heat).where("heats.circuit_id": @circuit.id).where("heats.car_id": @car.id).where.not(total: nil).all.order(:total).limit(3)
  end
end
