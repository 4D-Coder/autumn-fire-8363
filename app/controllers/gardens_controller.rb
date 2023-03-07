class GardensController < ApplicationController
  def show
    @garden = Garden.find(params[:id])
    @plants_under_100 = @garden.distinct_under_100
  end
end