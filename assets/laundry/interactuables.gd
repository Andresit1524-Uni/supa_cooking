extends Node2D

@onready var Player: Character = $"../Character"


@onready var clean_dishes: Area2D = $clean_dishes
@onready var dirty_dishes: Area2D = $dirty_dishes
@onready var dishwasher: Area2D = $dishwasher

#Esta variable define el orden en el que se interactua con los elementos
var step:int = 0
#Variable que destina un numero de platos aleatorio para lavar
var number_plates:int = randi_range(1,6)

func _ready() -> void:
	Player.connect("object_interact",_on_object_interact)
	print(number_plates)
	
func _process(_delta: float) -> void:
	if number_plates == 0:
		dirty_dishes.visible = false
	else:
		pass
func _on_object_interact(object: CollisionObject2D) -> void:
	match object:
		null:
			return
		clean_dishes:
			if step == 2:
				print("ola causa")
				number_plates -= 1
				print(number_plates)
				stop_interact()
				step = 0
			else:
				stop_interact() 
				return
		dirty_dishes:
			if step == 0:
				print("ola pe")
				stop_interact() 
				step += 1
			else:
				stop_interact() 
				return
		dishwasher:
			if step == 1:
				print("ola pepito")
				stop_interact()
				step += 1
			else:
				stop_interact() 
				return

func stop_interact() -> void:
	await get_tree().create_timer(0.1).timeout
	Player.stop_interact()
