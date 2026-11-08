## Contiene la lógica base de un personaje, incluyendo movimiento
class_name Character extends CharacterBody2D


## Especies disponibles
enum Species {
	BIRD_BLUE,
	BIRD_WHITE,
	CAR_ORANGE,
	CAR_GRAY,
	FOX,
	RACCOON,
}


## Dirección en la que se apunta
const Directions = {
	FRONT = &"front",
	BACK = &"back",
	LEFT = &"left",
	RIGHT = &"right",
}


## Velocidad de caminata
@export var speed: float = 100.0
## Especie del personaje
@export var species := Species.RACCOON:
	set = set_species

@export_group("Dependencias")
## Animaciones de cada especie
@export var character_species: Dictionary[Species, SpriteFrames]


@onready var collision_shape: CollisionShape2D = $"CollisionShape"
@onready var sprites: AnimatedSprite2D = $"Sprites"


## Dirección en la que apunta el personaje, para sus animaciones
var facing_direction: StringName = Directions.FRONT


func _ready() -> void:
	randomize_species()


## Obtiene la dirección del movimiento de forma centralizada
func get_input_vector() -> Vector2:
	return Input.get_vector(&"left", &"right", &"up", &"down")


## Actualiza la dirección en la que se mueve el personaje
func update_facing_dir(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		return

	if abs(direction.x) >= abs(direction.y):
		# Horizontal
		facing_direction = Directions.RIGHT if direction.x > 0 else Directions.LEFT
	else:
		# Vertical
		facing_direction = Directions.FRONT if direction.y > 0 else Directions.BACK


#region Especies y animaciones


## Aplica la animación para el personaje por su nombre. La dirección es automática
func play_animation(anim_prefix: StringName) -> void:
	sprites.play(anim_prefix + "_" + facing_direction)


## Cambia la especie del personaje
func set_species(new_species: Species) -> void:
	sprites.sprite_frames = character_species[new_species]


## Aleatoriza la especie del personaje
func randomize_species() -> void:
	species = Species.values().pick_random()


#endregion
