class_name TileBar extends HBoxContainer


@export_range(0, 100) var capacity: int = 5:
	set(value):
		capacity = value
		if not is_node_ready(): await ready
		set_capacity()

@export_group("Dependencias")
@export var tile_scene: PackedScene


func _ready() -> void:
	set_capacity()


## Actualiza la capacidad del inventario
func set_capacity() -> void:
	if not tile_scene:
		return

	# Diferencia
	var diff := capacity - get_child_count()
	if diff == 0: return

	# Añade los faltantes
	if diff > 0:
		for i in diff:
			add_child(tile_scene.instantiate())
		return

	# Elimina los sobrantes
	for i in -diff:
		var child := get_child(get_child_count() - 1)
		remove_child(child)
		child.queue_free()
