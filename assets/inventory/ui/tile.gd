## Casilla que almacena un elemento del inventario, mostrando su sprite y cantidad
class_name Tile extends Panel


@export_group("Datos")
## Ingrediente que almacena la casilla
@export var ingredient := FoodData.Ingredients.NONE:
	set(value):
		ingredient = value
		_set_sprite(value)
		_update_sprite()

## Cantidad actual del ingrediente en la casilla
@export var count: int = 0:
	set(value):
		count = value
		_update_label()


@export_group("Interfaz")
## Margen, proporcional al tamaño de la casilla
@export_range(0, 0.5, 0.05) var margin: float = 0.2:
	set(value):
		margin = value
		_update_sprite()

## Hace la casilla transparente
@export var transparent := false:
	set(value):
		transparent = value
		_update_type()


@onready var sprite: Sprite2D = $Sprite
@onready var label: Label = $Label
@onready var default_stylebox := get_theme_stylebox(&"panel")


## Sprites de las frutas. Inyectado por [TileBar]
var food_sprites: FoodSprites


func _ready() -> void:
	_update_sprite()
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
	if not sprite or not food_sprites: return
	sprite.texture = food_sprites.ingredient_sprites.get(new_ingredient)


## Actualiza el tipo de panel del tile
func _update_type() -> void:
	@warning_ignore("incompatible_ternary")
	add_theme_stylebox_override(
		&"panel",
		StyleBoxEmpty.new() if transparent else default_stylebox
	)


## Cambia el tamaño y la posición del sprite
func _update_sprite() -> void:
	if not sprite or not sprite.texture: return

	var desired_size: float = min(size.x, size.y) * (1 - margin)
	var sprite_size := sprite.texture.get_size()
	sprite.position = size / 2
	sprite.scale = Vector2.ONE * (desired_size / min(sprite_size.x, sprite_size.y))


## Acomoda el sprite cuando el panel cambia de tamaño
func _notification(what: int) -> void:
	if what == NOTIFICATION_RESIZED:
		_update_sprite()
