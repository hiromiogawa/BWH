class CircuitsController < ApplicationController
  before_action :require_user_logged_in, only: [:edit, :update, :destroy]

  def index
    @circuits = Circuit.all
  end

  def show
    @circuit = Circuit.find(params[:id])
    @events = @circuit.events.all.order(day: "DESC").page(params[:page]).per(10)
    @datalists = Datalist.includes(:event).where("events.circuit_id": @circuit.id).all
    if logged_in?
      if current_user.partake?(@circuit)
        @event = @circuit.events.build
      end
    end
    @besttimes =
      @datalists.map do |data|
        @bestheats = data.heats.all
        @bestheats.map do |heat|
          heat.laptimes.minimum(:total)
        end
      end

    unless @besttimes.blank?
      @besttime = @besttimes.min.min
      @heats = Heat.includes(:laptimes, :datalist).where("laptimes.total": @besttime).where("datalists.id": @datalists).all
    end
  end

  def new
    @circuit = Circuit.new
  end

  def create
    @circuit = Circuit.new(circuit_params)

    if @circuit.save
      flash[:success] = 'サーキット が正常に追加されました'
      redirect_to @circuit
    else
      flash.now[:danger] = 'サーキット が追加されませんでした'
      render :new
    end
  end

  def edit
    @circuit = Circuit.find(params[:id])
  end

  def update
    @circuit = Circuit.find(params[:id])

    if @circuit.update(circuit_params)
      flash[:success] = 'サーキット は正常に更新されました'
      redirect_to @circuit
    else
      flash.now[:danger] = 'サーキット は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @circuit = Circuit.find(params[:id])
    @circuit.destroy

    flash[:success] = 'サーキット は正常に削除されました'
    redirect_to circuits_url
  end

  private

  # Strong Parameter
  def circuit_params
    params.require(:circuit).permit(:name, :img)
  end

end
