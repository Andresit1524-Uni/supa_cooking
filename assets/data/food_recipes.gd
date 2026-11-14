class_name FoodRecipes

## Recetas para cada plato (plato -> lista de ingredientes requeridos)
@export var recipes: Dictionary[FoodData.Dishes, Array] = {
	FoodData.Dishes.SALAD: [
		FoodData.Ingredients.LETTUCE,
		FoodData.Ingredients.TOMATO,
	],
	FoodData.Dishes.BURGER: [
		FoodData.Ingredients.BREAD,
		FoodData.Ingredients.MEAT,
		FoodData.Ingredients.CHEESE,
		FoodData.Ingredients.LETTUCE,
	],
	FoodData.Dishes.SANDWICH: [
		FoodData.Ingredients.BREAD,
		FoodData.Ingredients.CHEESE,
		FoodData.Ingredients.TOMATO,
	],
}
