require 'rails_helper'

RSpec.describe 'Plots Index Page' do
  describe 'As a visitor' do
    context "When I visit the plots index" do
      before :each do
        @garden_1 = Garden.create(name: "Beautiful Gardens", organic: true)
        @garden_2 = Garden.create(name: "Cool Gardens", organic: false)

        @plot_1 = @garden_1.plots.create(number: "1", size: "Small", direction: "North")
        @plot_2 = @garden_1.plots.create(number: "2", size: "Medium", direction: "South")
        @plot_3 = @garden_2.plots.create(number: "3", size: "Large", direction: "East")

        @plant_1 = Plant.create(name: "bush", description: "gorgeous to look at", days_to_harvest: 65)
        @plant_2 = Plant.create(name: "tree", description: "gorgeous to look at", days_to_harvest: 42)
        @plant_3 = Plant.create(name: "flowers", description: "gorgeous to look at", days_to_harvest: 12)
        @plant_4 = Plant.create(name: "grass", description: "gorgeous to look at", days_to_harvest: 29)
        @plant_5 = Plant.create(name: "succulant", description: "gorgeous to look at", days_to_harvest: 30)

        PlantPlot.create(plant_id: @plant_1.id, plot_id: @plot_1.id)
        PlantPlot.create(plant_id: @plant_2.id, plot_id: @plot_1.id)
        PlantPlot.create(plant_id: @plant_3.id, plot_id: @plot_2.id)
        PlantPlot.create(plant_id: @plant_4.id, plot_id: @plot_1.id)
        PlantPlot.create(plant_id: @plant_4.id, plot_id: @plot_2.id)

        visit plots_path
      end

      it "sees a list of all plot numbers, and under each plot number I see the names of all that plot's plants" do

        within("div#plot_details-#{@plot_1.id}") do
          expect(page).to have_content("Plants for Plot ##{@plot_1.number}")
          expect(page).to have_content(@plant_1.name)
          expect(page).to have_content(@plant_2.name)
          expect(page).to have_content(@plant_4.name)
        end

        within("div#plot_details-#{@plot_2.id}") do
          expect(page).to have_content("Plants for Plot ##{@plot_2.number}")
          expect(page).to have_content(@plant_3.name)
          expect(page).to have_content(@plant_4.name)
        end

        within("div#plot_details-#{@plot_3.id}") do
          expect(page).to have_content("Plants for Plot ##{@plot_3.number}")
        end
      end

      it "Next to each plant I see a link or button to remove the plant from that plot" do
    
        within("div#plot-#{@plot_1.id}_plant-#{@plant_4.id}") do
          expect(page).to have_content(@plant_4.name)
          expect(page).to have_button("Delete")
        end


      end

      it "I click the link, and I'm returned to the plot index page" do
        within("div#plot-#{@plot_1.id}_plant-#{@plant_4.id}") do
          expect(page).to have_content(@plant_4.name)
          expect(page).to have_button("Delete")
          
          click_button "Delete"
        end

        expect(current_path).to eq(plots_path)
        save_and_open_page
        within("div#plot_details-#{@plot_1.id}") do
          expect(page).to_not have_content("#{@plant_4.name}")
        end

        within("div#plot_details-#{@plot_2.id}") do
          expect(page).to have_content("#{@plant_4.name}")
        end
      end
    end
  end
end