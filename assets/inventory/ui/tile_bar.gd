## Clase que gestiona la barra del inventario
class_name TileBar extends GridContainer


## Capacidad del inventario
@export_range(0, 100) var capacity: int = 5:
	set(value):
		capacity = value
		if not is_node_ready(): await ready
		_set_capacity()

@export_group("Dependencias")
## Escena del [Tile] para las casillas
@export var tile_scene: PackedScene
## Recurso [FoodSprites] para acceder a los sprites
@export var food_sprites: FoodSprites

@export var objetive: TileBar



func _ready() -> void:
	SignalBus.inventory_updated.connect(_update_bar)
	connect_pressed()
	for child: Tile in get_children():
		child.food_sprites = food_sprites
	

## Actualiza la capacidad de casillas y retorna si hubo cambios
func _set_capacity() -> bool:
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


## Actualiza la vista de las casillas a partir de los stacks de Inventory
func _update_bar(stacks: Array[Inventory.Stack]) -> void:
	for i in get_child_count():
		var tile := get_child(i) as Tile
		if not tile: continue

		tile.set_data(
			stacks[i].type if i < stacks.size() else FoodData.Ingredients.NONE,
			stacks[i].count if i < stacks.size() else 0
		)


## Cambia la transparencia de las casillas
func change_transparency(transparent: bool) -> void:
	for child: Tile in get_children():
		child.flat = transparent


func connect_pressed() -> void:
	for child: Tile in get_children():
		if child.pressed.is_connected(func() :_on_child_pressed(child)):
			continue
		child.pressed.connect(func() :_on_child_pressed(child))

func _on_child_pressed(child: Tile ):
	if objetive == null:
		return
	_transfer_data(Inventory.Stack.new(child.ingredient, child.count), objetive)
	


func _transfer_data(items: Inventory.Stack, tilebar: TileBar) -> void:
	if tilebar == self:
		return
	var transfered := InventoryManager.push(items.type, items.count, tilebar)
	InventoryManager.pop(items.type, transfered, self)
