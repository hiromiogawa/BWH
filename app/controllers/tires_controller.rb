class TiresController < ApplicationController

  def index
    @tires = Tire.all.order(:tirename)
  end

  def show
    @tire = Tire.find(params[:id])
  end

  def new
    @tire = Tire.new
  end

  def create
    @tire = Tire.new(tire_params)

    if @tire.save
      flash[:success] = 'タイヤ が正常に追加されました'
      redirect_to @tire
    else
      flash.now[:danger] = 'タイヤ が追加されませんでした'
      render :new
    end
  end

  def edit
    @tire = Tire.find(params[:id])
  end

  def update
    @tire = Tire.find(params[:id])

    if @tire.update(tire_params)
      flash[:success] = 'タイヤ は正常に更新されました'
      redirect_to @tire
    else
      flash.now[:danger] = 'タイヤ は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @tire = Tire.find(params[:id])
    @tire.destroy

    flash[:success] = 'タイヤ は正常に削除されました'
    redirect_to tires_url
  end

  private

  # Strong Parameter
  def tire_params
    params.require(:tire).permit(:tirename)
  end

end
