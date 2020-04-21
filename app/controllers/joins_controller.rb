class JoinsController < ApplicationController

  def create
    @circuit = Circuit.find(params[:circuit_id])
    if params[:type] == 'Partake'
      current_user.partake(@circuit)
      flash[:success] = 'マイサーキットを追加しました'
    end

    redirect_to @circuit
  end

  def destroy
    @circuit = Circuit.find(params[:circuit_id])
    if params[:type] == 'Partake'
      current_user.unpartake(@circuit)
      flash[:success] = 'マイサーキットから削除しました'
    end

    redirect_to @circuit
  end
end
