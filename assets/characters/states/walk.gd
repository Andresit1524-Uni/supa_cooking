## Caminata del personaje
class_name CharacterWalk extends BaseState


## Jugador, tipado por seguridad
var character: Character


func start() -> void:
	character = controlled_node as Character


func physics_update(_delta: float) -> void:
	if not character:
		return

	var direction := character.get_input_vector()
	if direction == Vector2.ZERO:
		to_state.emit(CharacterIdle)
		return

	character.update_facing_dir(direction)
	character.velocity = direction * character.speed
	character.move_and_slide()
	character.play_animation(&"walk")
