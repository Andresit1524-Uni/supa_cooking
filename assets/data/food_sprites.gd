## Recurso que almacena los sprites de alimentos y platos
class_name FoodSprites extends Resource

## Sprites de ingredientes indexados por su enum
@export var ingredient_sprites: Dictionary[FoodData.Ingredients, Texture2D]

## Sprites de platos indexados por su enum
@export var dish_sprites: Dictionary[FoodData.Dishes, Texture2D]
