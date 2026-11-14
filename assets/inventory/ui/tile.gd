## Botón/casilla que almacena un stack del inventario, y lo muestra
class_name Tile extends Button


## Ingrediente que almacena la casilla
@export var ingredient := FoodData.Ingredients.NONE:
	set(value):
		ingredient = value
		_set_sprite(value)

## Cantidad actual del ingrediente en la casilla
@export_range(0, 100) var count: int = 0:
	set(value):
		count = value
		_update_label()


@onready var label: Label = $Label


## Sprites de las frutas. Inyectado por [TileBar]
var food_sprites: FoodSprites


func _ready() -> void:
	_update_label()


## Configura el estado visual de la casilla
func set_data(new_ingredient: FoodData.Ingredients, new_count: int) -> void:
	ingredient = new_ingredient
	count = new_count
	label.visible = new_count != 0


## Actualiza la etiqueta de la cuenta
func _update_label() -> void:
	if not label: return
	label.text = str(count)


## Coloca el sprite del alimento dado
func _set_sprite(new_ingredient: FoodData.Ingredients) -> void:
	if not food_sprites: return
	icon = food_sprites.ingredient_sprites.get(new_ingredient)
