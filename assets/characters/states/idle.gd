## Estado de reposo del personaje
class_name CharacterIdle extends BaseState


## Jugador, tipado por seguridad
var character: Character


func start() -> void:
	character = controlled_node as Character

	# Primer arranque del personaje para evitar crashes
	if not character.is_node_ready():
		await character.ready

	character.velocity = Vector2.ZERO
	character.play_animation(&"idle")


func physics_update(_delta: float) -> void:
	if not character: return

	var direction := character.get_input_vector()

	# Caminata
	if direction != Vector2.ZERO:
		to_state.emit(CharacterWalk)
		return

	# Interacción
	if Input.is_action_just_pressed(&"interact"):
		character.interact()

	character.velocity = Vector2.ZERO
	character.move_and_slide()
	character.play_animation(&"idle")
