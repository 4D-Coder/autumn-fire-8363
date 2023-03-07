require 'rails_helper'

RSpec.describe 'Gardens Show Page' do
  describe 'As a visitor' do
    context "When I visit the garden show" do
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

        visit garden_path(@garden_1.id)
      end

      it "I see a list of plants that are included in that garden's plots" do
        
        within("ul#garden-#{@garden_1.id}") do
          expect(page).to have_content(@plant_1.name)
          expect(page).to have_content(@plant_3.name) 
          expect(page).to have_content(@plant_4.name) 
        end
      end

      it "I see that this list is unique (no duplicate plants), And I see that this list only includes plants that take less than 100 days to harvest" do
        expect(page).to have_content(@plant_4.name).once
        expect(page).to_not have_content(@plant_2.name)
        expect(page).to_not have_content(@plant_5.name)
      end
    end
  end
end