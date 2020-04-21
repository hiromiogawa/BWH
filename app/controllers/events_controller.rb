class EventsController < ApplicationController

  def show
    @event = Event.find(params[:id])
    @circuit = Circuit.find(params[:circuit_id])
    @datalists = @event.datalists.all
    if current_user.dataregister?(@event)
      @datalist = @event.datalists.build
    end

    # ベストタイム
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

  def create
    @circuit = Circuit.find(params[:circuit_id])
    @event = @circuit.events.build(event_params)
    if @event.save
      flash[:success] = '開催日を追加しました。'
      redirect_to event_path(@event, :circuit_id => @circuit.id)
    else
      @events = @circuit.events.order('created_at DESC').page(params[:page])
      flash[:success] = '開催日を追加に失敗しました。'
      redirect_to circuit_path(@circuit, :circuit_id => @circuit.id, :event_id => @event.id )
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @circuit = @event.circuit
    @event.destroy
    flash[:success] = '開催日を削除しました。'
    redirect_to circuit_path(@circuit, :circuit_id => @circuit.id, :event_id => @event.id )
  end

  private

  def event_params
    params.require(:event).permit(:day)
  end
end
