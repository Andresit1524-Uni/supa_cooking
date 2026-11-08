## Pausa del personaje, para interacciones o menú de pausa
class_name CharacterStop extends BaseState


## El jugador, tipado por seguridad
var character: Character


func start() -> void:
    character = controlled_node as Character
    character.play_animation(&"idle")


func physics_update(_delta: float) -> void:
    if not character: return

    # Bloquea al personaje para que no pueda hacer más
    character.velocity = Vector2.ZERO
    character.move_and_slide()
