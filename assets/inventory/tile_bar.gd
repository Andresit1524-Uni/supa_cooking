class_name TileBar extends HBoxContainer


## Capacidad del inventario
@export_range(0, 100) var capacity: int = 5:
	set(value):
		capacity = value
		if not is_node_ready(): await ready
		set_capacity()

@export_group("Dependencias")
## Escena del [Tile] para las casillas
@export var tile_scene: PackedScene
## Recurso [FoodSprites] para acceder a los sprites
@export var food_sprites: FoodSprites


func _ready() -> void:
	for child: Tile in get_children():
		child.food_sprites = food_sprites


## Actualiza la capacidad del inventario y retorna si hubo cambios
func set_capacity() -> bool:
	if not tile_scene: return false

	# Diferencia
	var diff := capacity - get_child_count()
	if diff == 0: return false

	# Añade los faltantes
	if diff > 0:
		for i in diff:
			var new_tile: Tile = tile_scene.instantiate()
			new_tile.food_sprites = food_sprites
			add_child(new_tile)

		return true

	# Elimina los sobrantes
	for i in -diff:
		var child := get_child(get_child_count() - 1)
		remove_child(child)
		child.queue_free()

	return true
