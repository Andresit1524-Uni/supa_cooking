class_name FoodRecipes

## Recetas para cada plato (plato -> lista de ingredientes requeridos)
@export var recipes: Dictionary[FoodData.Dishes, Array] = {
	FoodData.Dishes.HOTDOG: [
		FoodData.Ingredients.BREAD,
		FoodData.Ingredients.SAUSAGE,
	],
	FoodData.Dishes.SANDWICH: [
		FoodData.Ingredients.BREAD,
		FoodData.Ingredients.CHEDDAR,
		FoodData.Ingredients.STEAK,
		FoodData.Ingredients.TOMATO,
	],
	FoodData.Dishes.STEAK: [
		FoodData.Ingredients.STEAK,
		FoodData.Ingredients.TOMATO,
	]
}
