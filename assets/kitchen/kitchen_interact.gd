extends Node2D

# Script para recibir las señales del raycast a la hora de colisionar
# con las areas 2D

# Por Daniel Duran

# Le da el jugador al Script para poder acceder a sus funciones y señales
@onready var player: Character = $"../Character"


@onready var inventorybar: TileBar = $"../CanvasLayer/UI/InventoryBar"

# Le da las areas2d de la escena para compararlas con lo que colisione
# el raycast
@onready var fcupboard: Area2D = $food_cupboard
@onready var pcupboard: Area2D = $plate_cupboard
@onready var oven: Area2D = $oven
@onready var microwave: Area2D = $microwave
@onready var stove: Area2D = $stove
@onready var foodcupboard2: Area2D = $food_cupboard2





# Conecta la señal de interaccion del jugador
func _ready() -> void:
	var tile1: Tile = inventorybar.get_child(0)
	var tile2: Tile = inventorybar.get_child(1)
	var tile3: Tile = inventorybar.get_child(2)
	var tile4: Tile = inventorybar.get_child(3)
	var tile5: Tile = inventorybar.get_child(4)
	tile1.ingredient = FoodData.Ingredients.STEAK
	tile2.ingredient = FoodData.Ingredients.TOMATO
	tile3.ingredient = FoodData.Ingredients.STEAK
	tile4.ingredient = FoodData.Ingredients.TOMATO
	tile5.ingredient = FoodData.Ingredients.STEAK
	player.connect("object_interact", _on_object_interact)
	# Cambia la visibilidad de los objetos para evitar errores
	oven.visible = false
	microwave.visible = false
	stove.visible = false



# Maneja la interacción con los objetos de la cocina
func _on_object_interact(object: CollisionObject2D) -> void:
	var tile1: Tile = inventorybar.get_child(0)
	var tile2: Tile = inventorybar.get_child(1)
	var tile3: Tile = inventorybar.get_child(2)
	var tile4: Tile = inventorybar.get_child(3)
	var tile5: Tile = inventorybar.get_child(4)
	tile1.ingredient = FoodData.Ingredients.STEAK
	tile2.ingredient = FoodData.Ingredients.TOMATO
	tile3.ingredient = FoodData.Ingredients.STEAK
	tile4.ingredient = FoodData.Ingredients.TOMATO
	tile5.ingredient = FoodData.Ingredients.STEAK
	match object:
		null:
			return
		fcupboard:
			tile1.count += 1
			await get_tree().create_timer(0.5).timeout
			player.stop_interact()
		foodcupboard2:
			tile2.count += 1
			await get_tree().create_timer(0.5).timeout
			player.stop_interact()
		oven:
			if tile1.count == 0:
				await get_tree().create_timer(0.5).timeout
				player.stop_interact()
				return
			tile1.count -= 1
			tile3.count += 1
			cooking_sphere(object)
		stove:
			if tile2.count == 0:
				await get_tree().create_timer(0.5).timeout
				player.stop_interact()
				return
			tile2.count -= 1
			tile4.count += 1
			cooking_sphere(object)
		pcupboard:
			if (tile3.count != 0 and tile4.count != 0):
				tile5.count += 1
				tile3.count -= 1
				tile4.count -= 1
				await get_tree().create_timer(0.5).timeout
				player.stop_interact()
				return
			
			
	return


# Hace la animación cuando se está cocinando
func cooking_sphere(object: Node2D):
	object.visible = true
	object.modulate = Color.WHITE
	var tween: Tween = create_tween()
	tween.tween_property(object, "modulate", Color.RED, 2.5)
	await get_tree().create_timer(2.5).timeout
	player.stop_interact()
	object.visible = false
