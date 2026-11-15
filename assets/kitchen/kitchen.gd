extends Node2D

@onready var dish_cupboard: TileBar = $UI/dish_cupboard
@onready var ingred_cupboard: TileBar = $UI/ingred_cupboard
@onready var inventory_bar: TileBar = $CanvasLayer/UI/InventoryBar
@onready var shelfUi1: TileBar = $CanvasLayer/UI/ShelfUI1
@onready var shelfUi2: TileBar = $CanvasLayer/UI/ShelfUI2
@onready var fridgeUi: TileBar = $CanvasLayer/UI/FridgeUI
@onready var player: Character = $Character

var interact_shelf1: bool = false
var interact_shelf2: bool = false
var interact_fridge: bool = false


func _ready() -> void:
	SignalBus.connect("interact_shelf1", _on_shelf1_interact)
	SignalBus.connect("interact_shelf2", _on_shelf2_interact)
	SignalBus.connect("interact_fridge", _on_fridge_interact)


func _process(_delta: float) -> void:
	if interact_fridge:
		pass
	
	if interact_shelf1:
		InventoryManager.push(FoodData.Ingredients.CHEDDAR, 60, shelfUi1)
		inventory_bar.objetive = shelfUi1
		shelfUi1.objetive = inventory_bar
		interact_shelf1 = false
	
	if interact_shelf2:
		pass
	
	if Input.is_action_just_pressed("down"):
		InventoryManager.pop(FoodData.Ingredients.BREAD, 60, inventory_bar)

func _on_shelf1_interact():
	interact_shelf1 = true

func _on_shelf2_interact():
	interact_shelf2 = true

func _on_fridge_interact():
	interact_fridge = true
