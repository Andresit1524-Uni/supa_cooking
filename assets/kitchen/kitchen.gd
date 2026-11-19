extends Node2D

@onready var inventory_bar: TileBar = $CanvasLayer/UI/InventoryBar
@onready var inventory_bar_2: TileBar = $CanvasLayer/UI/InventoryBar2






func _ready() -> void:
	InventoryManager._init_stacks(inventory_bar)
	InventoryManager._init_stacks(inventory_bar_2)
	InventoryManager.push(FoodData.Ingredients.CHEDDAR, 10, inventory_bar)
	inventory_bar.objetive = inventory_bar_2
	inventory_bar_2.objetive = inventory_bar

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("down"):
		inventory_bar._update_bar(Inventory.Stack[])
	elif Input.is_action_just_pressed("up"):
		InventoryManager.pop(FoodData.Ingredients.BREAD, 10, inventory_bar_2)
		InventoryManager.pop(FoodData.Ingredients.BREAD, 10, inventory_bar)
