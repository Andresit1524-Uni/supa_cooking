extends Node2D

@onready var Player: Character = $"../Character"
@onready var bowl: Sprite2D = $"../Character/Bowl"

@onready var dishwasher: Area2D = $dishwasher
@onready var clean_dishes: platos = $clean_dishes
@onready var dirty_dishes: platos = $dirty_dishes

@onready var no_platos: Label = $"../UI/no_platos"

#Esta variable define el orden en el que se interactua con los elementos
var step:int = 0
#Variable que destina un numero de platos aleatorio para lavar
var number_plates:int = randi_range(1,6)

func _ready() -> void:
	Player.connect("object_interact",_on_object_interact)
	bowl.visible = false
	print(number_plates)
	
	
func _process(_delta: float) -> void:
	no_platos.text = str(number_plates)
	if number_plates == 0:
		dirty_dishes.visible = false
	else:
		pass
func _on_object_interact(object: CollisionObject2D) -> void:
	match object:
		null:
			return
		dirty_dishes:
			if step == 0:
				bowl.visible = true
				bowl.modulate = Color(1,1,1,1)
				stop_interact() 
				step += 1
			else:
				stop_interact() 
				return
		dishwasher:
			if step == 1:
				bowl.modulate = Color(0.947, 0.803, 0.769, 1.0)
				stop_interact()
				step += 1
			else:
				stop_interact() 
				return
		clean_dishes:
			if step == 2:
				print("no")
				bowl.visible = false
				number_plates -= 1
				print(number_plates)
				stop_interact()
				step = 0
			else:
				print("no")
				stop_interact() 
				return

func stop_interact() -> void:
	await get_tree().create_timer(0.1).timeout
	Player.stop_interact()
