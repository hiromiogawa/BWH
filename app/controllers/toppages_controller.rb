class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @have_cars = @user.have_cars.all
      @partake_circits = @user.partake_circits.all
    end
  end
end
