require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots) }
  end

  before :each do
    @garden_1 = Garden.create(name: "Beautiful Gardens", organic: true)
    @garden_2 = Garden.create(name: "Cool Gardens", organic: false)

    @plot_1 = @garden_1.plots.create(number: "1", size: "Small", direction: "North")
    @plot_2 = @garden_1.plots.create(number: "2", size: "Medium", direction: "South")
    @plot_3 = @garden_2.plots.create(number: "3", size: "Large", direction: "East")

    @plant_1 = Plant.create(name: "bush", description: "gorgeous to look at", days_to_harvest: 65)
    @plant_2 = Plant.create(name: "tree", description: "gorgeous to look at", days_to_harvest: 100)
    @plant_3 = Plant.create(name: "flowers", description: "gorgeous to look at", days_to_harvest: 12)
    @plant_4 = Plant.create(name: "grass", description: "gorgeous to look at", days_to_harvest: 29)
    @plant_5 = Plant.create(name: "succulant", description: "gorgeous to look at", days_to_harvest: 30)

    PlantPlot.create(plant_id: @plant_1.id, plot_id: @plot_1.id)
    PlantPlot.create(plant_id: @plant_2.id, plot_id: @plot_1.id)
    PlantPlot.create(plant_id: @plant_3.id, plot_id: @plot_2.id)
    PlantPlot.create(plant_id: @plant_4.id, plot_id: @plot_1.id)
    PlantPlot.create(plant_id: @plant_4.id, plot_id: @plot_2.id)
    PlantPlot.create(plant_id: @plant_5.id, plot_id: @plot_3.id)
  end

  describe "instance methods" do
    context "#distinct_under_100" do
      it "finds all plants harvestable under 100 days within an instance of a garden, and filters duplicates" do
        expect(@garden_1.distinct_under_100).to eq([@plant_1, @plant_3, @plant_4])
        expect(@garden_1.distinct_under_100).to include(@plant_4).once
        expect(@garden_1.distinct_under_100).to_not include(@plant_5)
      end
    end
  end
end
