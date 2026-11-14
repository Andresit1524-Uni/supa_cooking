## Casilla que almacena un elemento del inventario, mostrando su sprite
class_name Tile extends PanelContainer


## Margen, proporcional al tamaño de la casilla
@export_range(0, 0.5, 0.05) var margin: float = 0.2:
	set(value):
		margin = value
		_update_sprite_size()
## Ingrediente que almacena la casilla
@export var ingredient := FoodData.Ingredients.NONE:
	set(value):
		ingredient = value
		_set_sprite(value)
		_update_sprite_size()


@onready var sprite: Sprite2D = $Sprite


## Sprites de las frutas. Inyectado por [TileBar]
var food_sprites: FoodSprites


func _ready() -> void:
	_update_sprite_size()


### Implementa el sprite dado
func _set_sprite(new_ingredient: FoodData.Ingredients):
	if not sprite or not food_sprites: return
	sprite.texture = food_sprites.ingredient_sprites.get(new_ingredient)


#region Tamaño del sprite


## Actualiza el tamaño del sprite
func _update_sprite_size():
	if not sprite.texture: return

	var desired_size: float = min(size.x, size.y) * (1 - margin)
	var sprite_size := sprite.texture.get_size()
	sprite.position = size / 2
	sprite.scale = Vector2(1, 1) * (desired_size / min(sprite_size.x, sprite_size.y))


## Actualiza el sprite al cambiar el tamaño
func _notification(what: int) -> void:
	if what != NOTIFICATION_RESIZED: return
	_update_sprite_size()


#endregion
