class_name TileBar extends HBoxContainer


@export var capacity: int = 5:
	set = set_capacity


## Actualiza la capacidad del inventario. Lo limpia cuando pasa esto
func set_capacity(new_size: int) -> void:
	# Nuevas casillas
	var new_tiles: Array = range(new_size).map(func(_i): return Tile.new())

	# Borra los hijos
	for child in get_children():
		child.queue_free()
		await child.tree_exited

	# Añade los nuevos
	for tile: Tile in new_tiles:
		add_child(tile)
