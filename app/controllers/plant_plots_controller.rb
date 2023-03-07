class PlantPlotsController < ApplicationController
  def index
    @plots = Plot.all
  end

  def destroy
    @plot = Plot.find(params[:plot_id])
    @plot.plants.delete(params[:id])
    
    redirect_to plots_path
  end
end