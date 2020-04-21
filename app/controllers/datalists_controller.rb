class DatalistsController < ApplicationController

  def show
    @event = Event.find(params[:event_id])
    @circuit = Circuit.find(params[:circuit_id])
    @datalist = Datalist.find(params[:id])
    @heats = @datalist.heats.all.order(:number )
    @besttimes =
      @heats.map do |heat|
        heat.laptimes.minimum(:total)
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
    @datalists = Datalist.includes(:event).where("events.circuit_id": @circuit.id).all
    @besttimes =
      @datalists.map do |data|
        @heats = data.heats.all
        @heats.map do |heat|
          heat.laptimes.minimum(:total)
        end
      end
    unless @besttimes.blank?
      @besttime = @besttimes.min.min
      @heats = Heat.includes(:laptimes).where("laptimes.total": @besttime).all
    end
  end
end
