## Modificación de [Character] que no se controla por el jugador
class_name NPCCharacter extends Character

## Tolerancia en píxeles para considerar que llegó al objetivo
const pos_tolerance = 4.0


## Posición de destino
@onready var target_position: Vector2 = global_position


## Indica si prioriza moverse en el eje horizontal (X) antes que en vertical (Y)
var side_first: bool = true


func _ready() -> void:
	species = Species.values().pick_random()


## Envía al NPC al destino. 'side' determina si prioriza horizontal (X) o vertical (Y)
func send_to(global_target: Vector2, side := false) -> void:
	target_position = global_target
	side_first = side


## Calcula la dirección para llegar al destino del jugador
func get_input_vector() -> Vector2:
	# Si ya llegó al objetivo, se detiene
	if global_position.distance_to(target_position) <= pos_tolerance:
		return Vector2.ZERO

	var diff := target_position - global_position

	if side_first:
		# Primero horizontal, luego vertical
		if abs(diff.x) > pos_tolerance:
			return Vector2.LEFT if diff.x < 0 else Vector2.RIGHT

		if abs(diff.y) > pos_tolerance:
			return Vector2.UP if diff.y < 0 else Vector2.DOWN
	else:
		# Primero vertical, luego horizontal
		if abs(diff.y) > pos_tolerance:
			return Vector2.UP if diff.y < 0 else Vector2.DOWN

		if abs(diff.x) > pos_tolerance:
			return Vector2.LEFT if diff.x < 0 else Vector2.RIGHT

	return Vector2.ZERO


## Bloquea todas las interacciones
func interact() -> bool: return false
