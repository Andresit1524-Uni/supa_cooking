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
@onready var queue: Area2D = $queue
@onready var npcqueue: NPCQueue = $"../NpcQueue"





# Conecta la señal de interaccion del jugador
func _ready() -> void:
	player.connect("object_interact", _on_object_interact)
	# Cambia la visibilidad de los objetos para evitar errores
	oven.visible = false
	microwave.visible = false
	stove.visible = false



# Maneja la interacción con los objetos de la cocina
func _on_object_interact(object: CollisionObject2D) -> void:
	match object:
		null:
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
