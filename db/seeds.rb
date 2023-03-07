# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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