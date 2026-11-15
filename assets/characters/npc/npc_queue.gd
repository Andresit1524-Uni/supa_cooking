class_name NPCQueue extends Node2D


const WALK_DISTANCE = 300


## Distancia entre personajes
@export var distance: float = 15
## Cantidad de personajes
@export var npc_count: int = 20

@export_group("Dependencias")
## Escena del personaje
@export var npc_scene: PackedScene


## Lista de NPCs
var npc_list: Array[NPCCharacter]


func _ready() -> void:
	# Limpia los hijos
	for child: Character in get_children():
		remove_child(child)
		child.queue_free()

	# Inicializa los personajes
	for i in npc_count:
		# await get_tree().create_timer(1).timeout
		var new_npc: NPCCharacter = npc_scene.instantiate()
		var new_pos := Vector2.DOWN * distance * i
		new_npc.position = new_pos
		add_child(new_npc)
		npc_list.append(new_npc)

		# Ubica los personajes
		new_npc.target_position = to_global(new_pos)
		new_npc.update_facing_dir(Vector2.UP)
		new_npc.play_animation(&"idle")


## Saca a un npc de la fila
func pop_npc() -> void:
	if npc_count == 0: return

	var front: NPCCharacter = npc_list.pop_front()
	front.target_position += Vector2.LEFT * WALK_DISTANCE

	# Adelanta los demás
	for npc in npc_list:
		npc.target_position += Vector2.UP * distance

	# Elimina
	await get_tree().create_timer(2).timeout
	front.queue_free()
