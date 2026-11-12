## Caminata del personaje
class_name CharacterWalk extends BaseState


## Jugador, tipado por seguridad
var character: Character


func start() -> void:
	character = controlled_node as Character


func physics_update(_delta: float) -> void:
	if not character:
		return

	# Fin de la caminata
	var direction := character.get_input_vector()
	if direction == Vector2.ZERO:
		to_state.emit(CharacterIdle)
		return

	# Interacción
	if Input.is_action_just_pressed(&"interact"):
		var interaction := character.interact()
		if interaction: to_state.emit(CharacterStop)
		return

	character.update_facing_dir(direction)
	character.update_raycast(direction)
	character.velocity = direction * character.speed
	character.move_and_slide()
	character.play_animation(&"walk")
