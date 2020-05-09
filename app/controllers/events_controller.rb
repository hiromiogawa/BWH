class EventsController < ApplicationController
  before_action :require_user_logged_in, only: [:edit, :update, :destroy]

  def show
    @event = Event.find(params[:id])
    @circuit = Circuit.find(params[:circuit_id])
    @datalists = @event.datalists.all
    if logged_in?
      if current_user.dataregister?(@event)
        @datalist = @event.datalists.build
      end
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
